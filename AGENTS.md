# AGENTS.md

## Repository overview
- This is a database migration repository managed by Sqitch.
- Sqitch change scripts live under `deploy/`, with corresponding `revert/` and `verify/` scripts.
- `sqitch.conf` and `sqitch.plan` define the project configuration and change order.

## Important context
- Ignore all `*.sql` files in the repository root; they are legacy/integration artifacts and are not part of the Sqitch structure.

## Working guidelines
- When adding a change, update `sqitch.plan` and add matching scripts in `deploy/`, `revert/`, and `verify/`.
- Keep change names consistent across plan and scripts.
- Prefer small, reversible changes and ensure `verify/` scripts assert the intended effects.
- Avoid editing root-level `*.sql` files unless explicitly asked.

## Preparation / before commit
- Check for any root-level `*.sql` files. If present, propose integrating them into the Sqitch structure (add to `sqitch.plan` and create matching `deploy/`, `revert/`, and `verify/` scripts), or confirm they are intentional artifacts.
