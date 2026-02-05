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
- Do not hardcode database names (e.g., `office`) in Sqitch scripts. Avoid `USE \`office\`` and schema-qualified object names like `office.table` or `` `office`.proc``; keep scripts database-agnostic.
- Ensure scripts contain no NUL (`\0`) bytes; they cause `mysql` to error unless `--binary-mode` is used.
- In `verify/` scripts, use `sqitch.checkit(COUNT(*), 'message')` for validations instead of bare `SELECT 1`, with messages that describe the missing object.

## Preparation / before commit
- Check for any root-level `*.sql` files. If present, propose integrating them into the Sqitch structure (add to `sqitch.plan` and create matching `deploy/`, `revert/`, and `verify/` scripts), or confirm they are intentional artifacts.
