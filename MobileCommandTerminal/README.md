# HeavenzFire Mobile Command Terminal

A phone-first command console combining a terminal-style task composer with a browser-helper workflow inspired by Termux and userscript managers. This first slice is a static, installable PWA: it submits **task proposals**, shows task-inbox state, and never runs arbitrary shell text.

## Current scope

- Mobile-first terminal-like interface with command history and task status.
- Configurable API base URL for a paired HeavenzFire task-inbox endpoint.
- Creates a proposed task record using the Unified Field task-inbox contract.
- Explicitly labels proposals as pending; this client does not approve or execute tasks.
- No embedded credentials, shell evaluator, hidden browser injection, or automatic execution.

## Integration boundary

The existing Windows task inbox prototype defaults to 127.0.0.1:18796; that loopback address is reachable only from the laptop itself, not from an Android phone. **Do not expose it by changing the bind address to 0.0.0.0.** Phone-to-laptop operation requires a separately reviewed authenticated transport (device pairing, per-device grant, replay protection, TLS/private tunnel, and scoped authorization). Until that transport is implemented and verified, use the UI in demo/local mock mode or from a browser on the laptop.

## Run locally

Open index.html in a modern browser. For service-worker/PWA installation, serve this folder over localhost or HTTPS. Configure an API base only after the backend is securely reachable from the phone.

## Task proposal format

    {
      "taskId": "hf-mobile-<unique-id>",
      "title": "Short task title",
      "description": "Task description",
      "createdAt": "ISO-8601 timestamp",
      "status": "proposed",
      "approvalState": "pending",
      "source": "mobile-command-terminal",
      "evidence": []
    }

The exact contract may be stricter in the current local runtime; the backend is authoritative and rejects invalid records. Never put secrets in task descriptions.

## Security roadmap

1. Match the phone app signing protocol to DeviceBridge KEYRING1.
2. Add authenticated phone-to-laptop transport without public listener exposure.
3. Route only allow-listed task types through the existing task inbox.
4. Require explicit laptop-side approval for execution; keep privileged, network, credential, and destructive actions separately gated.
5. Add contract tests, audit events, and integration tests before claiming end-to-end operation.
