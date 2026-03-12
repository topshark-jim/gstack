# gstack Universal Skills

Deterministic universal conversion of the upstream `gstack` skill pack into a multi-skill repo that installs cleanly with `npx skills`.

## Install

```bash
npx skills add https://github.com/topshark-jim/gstack -g --all -y
```

On this machine the global install path resolves to `~/.agents/skills` through the existing Codex symlink.

## Included Skills

- `browse`
- `plan-ceo-review`
- `plan-eng-review`
- `review`
- `ship`
- `retro`

## browse Dependency

`browse` uses the existing `agent-browser` CLI instead of the upstream bundled browser. Make sure `agent-browser` is on `PATH`, and run `agent-browser install` once if browser binaries are missing.

## Upstream Sync

Re-run the full conversion against the latest upstream state with one command:

```bash
./scripts/sync-upstream.sh
```

That command fetches `upstream/main`, regenerates `skills/*`, updates `UPSTREAM_COMMIT`, runs validation, and refreshes the global installed copies under `~/.agents/skills`.

## Validation

```bash
./scripts/validate.sh
```
