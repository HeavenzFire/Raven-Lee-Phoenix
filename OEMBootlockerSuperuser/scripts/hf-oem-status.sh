#!/system/bin/sh
# HeavenzFire OEM status probe — read-only; safe to run from Termux.
# Does not unlock, remount, patch, or change device settings.
getprop_value() {
  value="$(getprop "$1" 2>/dev/null)"
  if [ -n "$value" ]; then printf "%s" "$value"; else printf "unknown"; fi
}
has_su="unavailable"
su_path=""
for candidate in /system/bin/su /system/xbin/su /sbin/su /debug_ramdisk/su; do
  if [ -x "$candidate" ]; then has_su="detected"; su_path="$candidate"; break; fi
done
if [ "$has_su" = "unavailable" ] && command -v su >/dev/null 2>&1; then
  has_su="detected"
  su_path="$(command -v su 2>/dev/null)"
fi
json_escape() { printf "%s" "$1" | sed 's/\\/\\\\/g; s/"/\\"/g; s/\r/\\r/g; s/\n/\\n/g; s/\t/\\t/g'; }
printf '{\n'
printf '  "schema": "heavenzfire.oem-status.v1",\n'
printf '  "readOnly": true,\n'
printf '  "bootloaderLocked": "%s",\n' "$(json_escape "$(getprop_value ro.boot.flash.locked)")"
printf '  "bootloaderDeviceState": "%s",\n' "$(json_escape "$(getprop_value ro.boot.vbmeta.device_state)")"
printf '  "verifiedBootState": "%s",\n' "$(json_escape "$(getprop_value ro.boot.verifiedbootstate)")"
printf '  "verityMode": "%s",\n' "$(json_escape "$(getprop_value ro.boot.veritymode)")"
printf '  "oemUnlockAllowed": "%s",\n' "$(json_escape "$(getprop_value sys.oem_unlock_allowed)")"
printf '  "suDetection": "%s",\n' "$has_su"
printf '  "suPath": "%s",\n' "$(json_escape "${su_path:-unknown}")"
printf '  "androidRelease": "%s",\n' "$(json_escape "$(getprop_value ro.build.version.release)")"
printf '  "deviceManufacturer": "%s",\n' "$(json_escape "$(getprop_value ro.product.manufacturer)")"
printf '  "deviceModel": "%s"\n' "$(json_escape "$(getprop_value ro.product.model)")"
printf '}\n'
