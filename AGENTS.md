# Repository Guidelines

## Project Structure & Module Organization
Scripts live under `components/`, grouped by tool (for example `components/rust.sh` and `components/golang.sh`) and sourced through `components/_includes.sh`. Reusable helpers sit in `lib/`, with logging primitives in `lib/log.sh` that every installer can source via `lib/_includes.sh`. The executable `setup` at the repository root wires everything together; treat it as the entry point for orchestrating component installs during bootstrap drills.

## Build, Test, and Development Commands
- `./setup all` — runs the full workstation bootstrap sequence in the order defined in `setup`.
- `./setup <component>` — installs or configures a single focus area such as `./setup fish` or `./setup docker`.
- `bash -n components/<file>.sh` — syntax-checks a script before committing.
Keep commands idempotent; every script should succeed on repeat execution without manual cleanup.

## Coding Style & Naming Conventions
Author scripts in POSIX-friendly Bash with `#!/usr/bin/env bash` and `set -euo pipefail` declared before any logic. Use two spaces for indentation and prefer `namespace::verb` function names (for example `golang::install`) to match existing modules. Source shared helpers explicitly (`source "${GIT_ROOT}/lib/_includes.sh"`) and centralize side effects in functions, not at file load time.

## Testing Guidelines
There is no automated test harness; rely on fast feedback loops. Run `bash -n` and `shellcheck` locally, then execute `./setup <component>` on a fresh shell session or container to validate installs. For network-reliant installers (e.g., `cargo install` in `components/utilities.sh`) confirm retries and version checks guard against stale toolchains.

## Commit & Pull Request Guidelines
Follow the short, imperative commit style already in history (`Add helper lib`, `Refactor script`). Squash noisy work-in-progress commits before opening a PR. Each PR should describe the scenario it enables, list notable commands touched, and include manual verification notes (command transcripts or screenshots when visual changes apply). Link related issues and call out any steps contributors must run after merging.

## Security & Configuration Tips
Review remote commands and URLs before upgrading installers; pin versions where possible. Avoid embedding personal tokens—reference expected environment variables or keychain entries instead. Document any new secrets in the PR so maintainers can provision them safely.
