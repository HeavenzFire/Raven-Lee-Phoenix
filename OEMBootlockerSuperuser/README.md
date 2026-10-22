# HeavenzFire OEM Bootlocker + Superuser

A device-owned Android administration module for boot-chain visibility, root-capability detection, and permissioned maintenance. This module does **not** unlock a bootloader, exploit Android, bypass verified boot, or manufacture root privileges.

## Components
- `scripts/hf-oem-status.sh`: read-only Android/Termux status collector.
- `policy/privileged-actions.example.json`: sample least-privilege action policy.
- This specification: architecture, integration boundaries, and test expectations.

## Capability truth model
The UI must report each capability as `available`, `unavailable`, or `unknown`; never infer root from a UI toggle.
- Bootloader state: use device properties when exposed; report `unknown` if missing or ambiguous.
- Verified Boot: report `ro.boot.verifiedbootstate` and `ro.boot.vbmeta.device_state` without changing them.
- Superuser: detect a known `su` executable and perform only a non-destructive identity check. Detection alone does not prove every command can be authorized.
- OEM unlock eligibility: report only vendor-exposed status; do not initiate an unlock.

## Security boundary
1. Status collection is read-only.
2. Privileged actions must be declared in a versioned allowlist and bound to a specific device/session.
3. Require explicit user confirmation for each privileged action; show exact command, target, and expected impact before execution.
4. Never accept arbitrary shell text from a network client as a privileged command.
5. Keep authorization tokens out of logs and source control. Use short-lived, revocable grants and replay-resistant request IDs.
6. Do not expose an unauthenticated root daemon or bind a privileged service to all network interfaces.
7. Unlocking a bootloader may wipe data and weaken device integrity; provide vendor-specific, model-specific instructions only after identifying the exact device and official support path.

## Current status
This is a source module, not installed OEM firmware. An Android app cannot become a real OEM/system app simply by installing a package. System signing, partition integration, and vendor-specific boot-chain support require legitimate device-owner/OEM control or a supported unlocked development device.

## Quick test (Termux / Android shell)
```sh
sh scripts/hf-oem-status.sh
```
The script emits JSON and does not change device state. Some properties may be absent on some Android versions or vendor builds.

## Roadmap
- [ ] Validate output on a named device/Android build.
- [ ] Add tests for missing properties, unavailable `su`, and malformed outputs.
- [ ] Connect status reports to the HeavenzFire mobile terminal through the existing authenticated task-inbox contract.
- [ ] Implement an action broker only after verifying device identity, grant issuance/revocation, and audit storage.
- [ ] Test on a spare, recoverable development device before boot-chain modifications.

## Device-specific implementation

- [FOXXD A67L build profile and verification checklist](./DEVICE-PROFILE.md)
- [Deterministic status-probe tests](./tests/test-status-probe.sh)
- [GitHub Actions workflow](../.github/workflows/oem-status-tests.yml)

The test workflow is configured, but no passing CI result is claimed until GitHub reports a completed run.
