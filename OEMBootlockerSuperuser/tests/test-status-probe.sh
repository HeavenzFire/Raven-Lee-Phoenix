#!/usr/bin/env sh
set -eu
SCRIPT="OEMBootlockerSuperuser/scripts/hf-oem-status.sh"
sh -n "$SCRIPT"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
cat > "$tmp/getprop" <<'MOCK'
#!/usr/bin/env sh
case "$1" in
  ro.boot.flash.locked) printf '1' ;;
  ro.boot.vbmeta.device_state) printf 'locked' ;;
  ro.boot.verifiedbootstate) printf 'green' ;;
  ro.product.manufacturer) printf 'FOXXD' ;;
  ro.product.model) printf 'A67L' ;;
  ro.product.device) printf 'A67L' ;;
  ro.build.version.release) printf '14' ;;
  *) printf '' ;;
esac
MOCK
chmod +x "$tmp/getprop"
PATH="$tmp:/usr/bin:/bin" sh "$SCRIPT" > "$tmp/status.json"
python3 - "$tmp/status.json" <<'PY'
import json, sys
with open(sys.argv[1], encoding="utf-8") as f:
    d = json.load(f)
assert d["schema"] == "heavenzfire.oem-status.v1"
assert d["readOnly"] is True
assert d["bootloaderLocked"] == "1"
assert d["bootloaderDeviceState"] == "locked"
assert d["verifiedBootState"] == "green"
assert d["deviceManufacturer"] == "FOXXD"
assert d["deviceModel"] == "A67L"
assert d["androidRelease"] == "14"
assert d["oemUnlockSupported"] == "unknown"
print("PASS: shell syntax, JSON validity, known properties, and unknown-property fallback")
PY
