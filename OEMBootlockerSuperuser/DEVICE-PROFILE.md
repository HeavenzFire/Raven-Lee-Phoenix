# Device profile: FOXXD A67L build identifier

User-provided Android build identifier: `Android_FOXXD_A67L_V1.0_260910`.

## Evidence status

- **Likely family:** FOXXD A67L. Public certification listings identify A67L as a FOXX Development smartphone. See [A67L certification summary](https://device.report/fccid/2aqrma67l) and [A67L device record/manual index](https://device.report/foxx/a67l).
- **Hardware/SoC:** community material associates some A67L variants with Unisoc/Spreadtrum SC9863A, but this does not prove the exact hardware revision or firmware in this request. Capture the device's live `ro.product.model`, `ro.product.device`, `ro.build.fingerprint`, Android release, and security patch before choosing any image.
- **Bootloader/root status:** UNKNOWN. No phone was connected to the Windows host during the last ADB check; the host returned no attached-device rows. No live device properties have been collected.
- **Build-specific support:** no official OEM unlock or firmware procedure has yet been verified for the exact `V1.0_260910` build.

## First verification — read-only

1. On the phone, open Settings → About phone and capture model, Android version, and build number.
2. If using USB, install/enable Android platform tools, connect a data-capable cable, enable Developer options and USB debugging, then authorize this PC on the phone. On the Windows host run `adb devices -l` and confirm the device appears as `device`, not `unauthorized`.
3. Run the status probe in Termux: `sh scripts/hf-oem-status.sh`. Save its JSON output without editing the reported values.
4. Compare Android settings, probe output, and (only if the owner intentionally enters bootloader/fastboot mode) read-only fastboot status output. Do not run an unlock, erase, flash, or partition-write command during identification.

## Unlock/root decision

Use the manufacturer's supported process if one exists for the exact model/build. A community guide exists for other A67L/SC9863A configurations, but its low-level bootloader modification/flash steps are not validated for this build and can brick the phone or erase data. This project will not treat that guide as a verified method, run exploit code, or flash guessed images.

If official unlock is unavailable, proceed with the unrooted device-management path: Termux user-space utilities, Android Debug Bridge when explicitly authorized, and the HeavenzFire authenticated task bridge. These do not confer OEM/system privileges.

## Acceptance criteria

- [ ] Exact model, device codename, build fingerprint, Android release and patch level captured.
- [ ] Status JSON parses and uses `unknown` when properties are unavailable.
- [ ] Bootloader state independently confirmed; OEM-unlock permission is not mistaken for current lock state.
- [ ] `su` detection is not represented as proof that root authorization works.
- [ ] No unlock/flash/write action taken without a verified device-specific path, a backup, and explicit user confirmation.
