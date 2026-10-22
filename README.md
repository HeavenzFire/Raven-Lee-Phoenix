# Raven-Lee-Phoenix

## HeavenzFire Mobile Command Terminal

A phone-first, terminal-style task proposal PWA with a planned browser-helper/userscript workflow is available in [`MobileCommandTerminal/`](./MobileCommandTerminal/). It currently supports a local demo queue and a configurable task-inbox API client. It does **not** execute arbitrary shell commands, and secure Android-to-Windows transport is still a separate integration step.

- [Open the terminal interface source](./MobileCommandTerminal/index.html)
- [Read setup and security notes](./MobileCommandTerminal/README.md)

## OEM Bootlocker + Superuser

A read-only Android boot-chain and superuser capability status module, with a deny-by-default privileged-action policy example, is available in [`OEMBootlockerSuperuser/`](./OEMBootlockerSuperuser/). It reports observable state; it does not unlock the bootloader, bypass verified boot, or grant root.

- [Module specification and safety boundary](./OEMBootlockerSuperuser/README.md)
- [Android status probe](./OEMBootlockerSuperuser/scripts/hf-oem-status.sh)
- [Privileged-action policy example](./OEMBootlockerSuperuser/policy/privileged-actions.example.json)
