# Opinion MySQL (Sqitch)

This repository manages database changes for the Opinion MySQL database using Sqitch.

## Structure
- `deploy/` - forward change scripts
- `revert/` - rollback scripts
- `verify/` - validation scripts
- `sqitch.plan` - ordered list of changes
- `sqitch.conf` - project configuration

## Important note
Root-level `*.sql` files are legacy/integration artifacts. Ignore them unless explicitly instructed otherwise.

## Workflow
1. Create a new change with a descriptive name.
2. Add the change to `sqitch.plan`.
3. Implement scripts in `deploy/`, `revert/`, and `verify/` with matching names.
4. Keep changes small and reversible; make `verify/` assert the intended effect.

## Sqitch basics
Common commands (run from repo root):

```sh
sqitch status
sqitch deploy
sqitch verify
sqitch revert
```
