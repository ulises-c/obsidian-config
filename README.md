# obsidian-config

Shared Obsidian configuration synced across all vaults in [obsidian-notes](https://github.com/ulises-c/obsidian-notes). Used as a git submodule at `.obsidian-sync/`.

## Contents

| Path | Purpose |
|---|---|
| `plugins/*/main.js`, `manifest.json` | Community plugin files |
| `themes/` | Theme files |
| `app.json` | General app settings |
| `appearance.json` | Theme and font settings |
| `core-plugins.json` | Core plugin toggle states |
| `community-plugins.json` | Community plugin list |
| `hotkeys.json` | Custom keybindings |
| `types.json`, `workspaces.json` | Property types, workspace layouts |
| `hooks/` | Git hooks for the parent vault repo |

## Excluded (vault-specific, never shared)

| File | Reason |
|---|---|
| `workspace.json` / `workspace-mobile.json` | Open panes and tabs |
| `graph.json` | Graph view position state |
| `plugins/*/data.json` | Per-vault plugin data |

## How it works

### Automatic sync (post-commit hook)

When any vault's `.obsidian/` changes in a commit to the parent repo:

1. The changed vault's config is promoted to this repo
2. Changes are committed and pushed to `main` here
3. Config is distributed to all other vaults' `.obsidian/` dirs
4. Propagated changes are staged for the next backup commit

Files in `hooks/` and repo metadata (`.git`, `README.md`) are always excluded from vault distribution.

### Pre-push hook

When the parent vault repo is pushed, this submodule is pushed first if it has unpushed commits. Prevents the parent repo from referencing a submodule commit that hasn't landed on GitHub yet.

### Git config (set by `make setup`)

```
submodule.recurse = true       # pull/push/fetch recurse into submodules
status.submoduleSummary = true # git status shows submodule state
diff.submodule = log           # git diff shows submodule commit log
fetch.recurseSubmodules = on-demand
```

## Updating config

Changes made through Obsidian's UI are picked up automatically on the next commit. To manually push a change or promote a specific vault's config:

```bash
# From the parent repo root
make push              # push any pending .obsidian-sync changes
make pull              # pull latest and distribute to all vaults
make promote VAULT="Personal"  # make Personal the source of truth
```
