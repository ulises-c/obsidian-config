# obsidian-config

Shared Obsidian configuration synced across all vaults.

## What's here

- Plugin list and plugin files (`plugins/`)
- Theme files (`themes/`)
- App settings (`app.json`, `appearance.json`, `core-plugins.json`, `community-plugins.json`)
- Hotkeys, types, workspaces

## What's NOT here

- `workspace.json` / `workspace-mobile.json` — open panes (vault-specific)
- `graph.json` — graph view state (vault-specific)
- `plugins/*/data.json` — per-vault plugin data

## How it works

A `post-commit` hook in the main Obsidian vault repo detects `.obsidian/` changes in any vault, promotes them here, and distributes to all other vaults automatically.
