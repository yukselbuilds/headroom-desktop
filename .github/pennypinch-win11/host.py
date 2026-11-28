from base64 import b64decode
import json
from pathlib import Path
import re
import socket
import subprocess
import time

socket_path = Path("qmp.socket").resolve()
receipts = Path("guest.serial")
BOOT_LIMIT_SECONDS = 1500
INSTALLED_TEST_LIMIT_SECONDS = 1230
ANNOTATED_EVENTS = {"boot", "specialize", "guest_entry", "setup", "before", "runtime", "installed", "ready", "exited", "complete", "duration", "host problem"}
guest = [
    "qemu-system-x86_64", "-enable-kvm", "-machine", "q35,smm=on", "-cpu", "host",
    "-smp", "4", "-m", "8192", "-S",
    "-global", "driver=cfi.pflash01,property=secure,value=on",
    "-drive", "if=pflash,format=raw,unit=0,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd,readonly=on",
    "-drive", "if=pflash,format=raw,unit=1,file=firmware-vars.fd",
    "-chardev", "socket,id=chrtpm,path=tpm-control.sock",
    "-tpmdev", "emulator,id=tpm0,chardev=chrtpm", "-device", "tpm-tis,tpmdev=tpm0",
    "-device", "qemu-xhci", "-device", "usb-tablet",
    "-display", "none", "-vga", "std", "-rtc", "base=localtime",
    "-drive", "if=none,id=system,file=clean.qcow2,format=qcow2",
    "-device", "ide-hd,drive=system,bus=ide.0,bootindex=0",
    "-drive", "if=none,id=media,file=windows.iso,format=raw,media=cdrom,readonly=on",
    "-device", "ide-cd,drive=media,bus=ide.2,bootindex=1",
    "-drive", "if=none,id=answer,file=answer.iso,format=raw,media=cdrom,readonly=on",
    "-device", "ide-cd,drive=answer,bus=ide.3",
    "-netdev", "user,id=nat", "-device", "e1000e,netdev=nat,id=guestnic",
    "-serial", "file:guest.serial", "-qmp", f"unix:{socket_path},server=on,wait=off",
]


def notice(name, data):
    data = json.dumps(data, separators=(",", ":"), ensure_ascii=True)
    if name in ANNOTATED_EVENTS:
        print(f"::notice title=Windows 11 {name}::{data}", flush=True)
    else:
        print(f"Windows 11 {name}: {data}", flush=True)


def qmp(stream, command, **arguments):
    stream.write(json.dumps({"execute": command, "arguments": arguments}).encode() + b"\n")
    while True:
        line = stream.readline()
        if not line:
            raise RuntimeError("monitor_disconnected")
        response = json.loads(line)
        if "error" in response:
            raise RuntimeError("monitor_command_failed_" + command)
        if "return" in response:
            return response["return"]


def setup_display(stream):
    # Keep the screenshot in the disposable runner. Report only recognized installation states.
    states = {
        "press any key to boot": "boot_prompt",
        "no bootable device": "no_boot_device",
        "no bootable disk": "no_boot_device",
        "installing windows": "installing",
        "where do you want to install windows": "disk_selection",
        "windows setup": "setup",
        "could not install required files": "setup_files_error",
        "windows installation failed": "setup_install_failed",
        "your pc/device needs to be repaired": "windows_recovery",
        "security violation": "firmware_security_violation",
        "bdsdxe: failed": "firmware_boot_failed",
        "could not parse or process": "answer_file_error",
        "let's connect you to a network": "oobe_network",
        "is this the right country": "oobe_region",
        "is this the right keyboard": "oobe_keyboard",
        "name your device": "oobe_device_name",
        "just a moment": "oobe_working",
        "pennypinch qa": "qa_account",
        "sign in": "sign_in",
        "getting ready": "getting_ready",
        "getting devices ready": "getting_devices_ready",
        "pennypinch": "application_title",
        "procedure entry point": "missing_entry_point",
        "could not be located": "missing_entry_point",
        "system error": "system_error",
        "application error": "application_error",
        "error": "error_text",
    }
    try:
        qmp(stream, "screendump", filename=str(Path("setup.ppm").resolve()))
        scan = subprocess.run(["tesseract", "setup.ppm", "stdout"], capture_output=True, check=True, timeout=10)
        screen = " ".join(scan.stdout.decode("utf-8", errors="replace").lower().split())
    except (RuntimeError, subprocess.SubprocessError):
        return ["diagnostic_unavailable"]
    result = sorted({value for key, value in states.items() if key in screen})
    if "error_text" in result:
        code = re.search(r"\b0x[0-9a-f]{8}\b", screen)
        if code:
            result.append(code[0])
    if "installing" in result:
        percentage = re.search(r"(\d{1,3})\s*%", screen)
        if percentage and 0 <= int(percentage[1]) <= 100:
            result.append(f"{percentage[1]}_percent")
    return result or ["unclassified"]


def skip_oobe_update(stream):
    screenshot = Path("setup.ppm")
    with screenshot.open("rb") as image:
        if image.readline() != b"P6\n" or image.readline().split() != [b"1280", b"800"]:
            return False
    scan = subprocess.run(["tesseract", str(screenshot), "stdout", "--psm", "11"],
                          capture_output=True, timeout=10)
    words = set(re.findall(rb"[a-z]+", scan.stdout.lower()))
    if scan.returncode != 0 or not {b"oobezdp", b"skip", b"wrong"} <= words:
        return False
    # This is the observed Skip button on the 1280 x 800 English OOBEZDP screen.
    qmp(stream, "input-send-event", events=[
        {"type": "abs", "data": {"axis": axis, "value": round(32767 * pixel / (size - 1))}}
        for axis, pixel, size in (("x", 914, 1280), ("y", 667, 800))
    ])
    for down in (True, False):
        qmp(stream, "input-send-event", events=[{"type": "btn", "data": {"down": down, "button": "left"}}])
        time.sleep(0.12)
    return True


def main(process):
    with socket.socket(socket.AF_UNIX) as monitor:
        monitor.settimeout(8)
        for _ in range(100):
            if socket_path.exists():
                break
            if process.poll() is not None:
                raise RuntimeError("vm_start_failed")
            time.sleep(0.1)
        monitor.connect(str(socket_path))
        with monitor.makefile("rwb", buffering=0) as stream:
            assert "QMP" in json.loads(stream.readline())
            qmp(stream, "qmp_capabilities")
            qmp(stream, "set_link", name="guestnic", up=False)
            qmp(stream, "cont")
            notice("boot", {"kvm": qmp(stream, "query-kvm")["enabled"], "disk": "new_qcow2"})
            start = time.monotonic()
            preflight = None
            setup_samples = []
            diagnostic = iter([3, 6, 10, 15, 23, 32, 90, 220, 380, *range(480, 1490, 60)])
            next_diagnostic = next(diagnostic)
            oobe_update_skipped = False
            done = 0
            while True:
                elapsed = time.monotonic() - start
                if not preflight and elapsed >= next_diagnostic:
                    states = setup_display(stream)
                    if elapsed >= 480 and not oobe_update_skipped:
                        oobe_update_skipped = skip_oobe_update(stream)
                        if oobe_update_skipped:
                            states.append("oobe_update_skipped")
                    setup_samples.append({"seconds": next_diagnostic, "screen": states})
                    notice(f"boot at {next_diagnostic} seconds", setup_samples[-1])
                    # A prompt after the installer restarts must time out to the installed disk.
                    if "boot_prompt" in states and elapsed < 45:
                        qmp(stream, "send-key", keys=[{"type": "qcode", "data": "ret"}], **{"hold-time": 250})
                    next_diagnostic = next(diagnostic, float("inf"))
                if receipts.exists():
                    raw = receipts.read_bytes()
                    lines = raw.split(b"\n")[:-1]
                    for line in lines[done:]:
                        if not line.startswith(b"PPAUDIT "):
                            continue
                        _, event, payload = line.split()
                        result = json.loads(b64decode(payload, validate=True))
                        notice(event.decode("ascii"), result)
                        if event == b"before":
                            assert not preflight and result["preflight"]["status"] == "ready"
                            notice("setup", {"samples": setup_samples, "preflight_after_seconds": round(elapsed, 3)})
                            preflight = time.monotonic()
                        if event == b"exited":
                            assert preflight and result["checks"]["normal_desktop_exit"]
                            qmp(stream, "set_link", name="guestnic", up=True)
                        if event == b"complete":
                            notice("duration", {"guest_seconds": round(time.monotonic() - start, 3)})
                            if not preflight:
                                notice("setup", {"samples": setup_samples, "preflight_after_seconds": None})
                            return result["status"] == "pass"
                    done = len(lines)
                if process.poll() is not None:
                    raise RuntimeError("vm_exited_before_receipt")
                if not preflight and elapsed >= BOOT_LIMIT_SECONDS:
                    notice("setup", {"samples": setup_samples, "preflight_after_seconds": None})
                    qmp(stream, "screendump", filename=str(Path("setup-timeout.ppm").resolve()))
                    raise RuntimeError("guest_timeout_before_baseline")
                if preflight and time.monotonic() - preflight >= INSTALLED_TEST_LIMIT_SECONDS:
                    raise RuntimeError("guest_timeout_after_baseline")
                time.sleep(1)


with subprocess.Popen(guest) as process:
    try:
        passed = main(process)
    except (RuntimeError, ValueError, OSError, AssertionError) as exc:
        notice("host problem", {"code": str(exc) if isinstance(exc, RuntimeError) else type(exc).__name__})
        passed = False
    finally:
        if process.poll() is None:
            process.terminate()
            try:
                process.wait(timeout=8)
            except subprocess.TimeoutExpired:
                process.kill()
if not passed:
    raise SystemExit(1)
