# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal Neovim configuration, managed by [lazy.nvim](https://github.com/folke/lazy.nvim). No build system, tests, or linters — changes are validated by launching `nvim` and using it. Leader key is `\` (both `mapleader` and `maplocalleader`).

## Entry point and load order

`init.lua` requires three modules in order:

1. `config.lazy` — bootstraps lazy.nvim (clones it if missing), sets `mapleader`/`maplocalleader`, then calls `lazy.setup({ spec = { { import = "plugins" } } })`. That import glob auto-loads every file under `lua/plugins/`, so **adding a new plugin = drop a `lua/plugins/<name>.lua` file that returns a lazy spec table**. No manual registration.
2. `config.general` — editor options, autocmds (relative-number toggle on focus, quickfix auto-open), and non-LSP keymaps.
3. `config.lsp` — diagnostic config + a single global `LspAttach` autocmd that installs all buffer-local LSP keymaps. Individual LSP plugin configs do NOT set their own keymaps; they only declare servers.

## LSP: server declaration vs. keymap wiring

Two files split the concern, and it's easy to put changes in the wrong one:

- **`lua/plugins/nvim-lspconfig.lua`** — declares servers in `opts.servers` and enables them via the new-style API: `vim.lsp.config(server, config); vim.lsp.enable(server)`. This is Neovim 0.11+ style; do not fall back to the old `require("lspconfig").<server>.setup{}` pattern. Adding a language means adding a key here (and installing the server binary on the system — this config does not use `mason.nvim`).
- **`lua/config/lsp.lua`** — the `LspAttach` autocmd defines `gd`, `gr`, `K`, `<leader>ca`, `<leader>cr`, `<leader>cf`, etc. once, globally. Telescope pickers are used for `gd`/`gr`/`gw`. Inlay hints are enabled here when the server supports them.

Python is intentionally configured with **three** servers running together — `pyright` (strict type checking), `pylsp` (configured to disable everything except flake8-driven diagnostics), and `ruff`. Don't collapse them without understanding the split.

## Treesitter: main branch, not master

`lua/plugins/nvim-treesitter.lua` pins the `main` branch of nvim-treesitter, which is a **rewritten API**. Key differences from the stable branch that appear in most online examples:

- No `ensure_installed` table. Parsers are installed imperatively: check `ts.get_installed()`, diff against the desired list, call `ts.install(missing)`.
- No `highlight`/`indent` config blocks. Highlighting is started per-buffer via a `FileType` autocmd calling `vim.treesitter.start(bufnr)`; indent is enabled by setting `indentexpr`.
- `nvim-treesitter-textobjects` is also on `main` and configured separately via `require("nvim-treesitter-textobjects").setup(...)`. Textobject keymaps (`af`, `if`, `ac`, `ic`) are set manually using `nvim-treesitter-textobjects.select`.

If you're adding treesitter functionality, verify examples target the main branch — master-branch snippets will silently misbehave.

## Filetype-specific overrides

`after/ftplugin/<ft>.lua` overrides buffer-local options per filetype (tab width, `expandtab`, `colorcolumn`, `fileformat`). This is the right place for language-specific editor settings — do not put them in `config/general.lua`. Python uses 4-space soft tabs with `colorcolumn = {"73", "79"}`; Lua uses 2-space.

## Completion

`blink.cmp` is the completion engine. Legacy `nvim-cmp` sources (e.g. `cmp-calc`) are pulled in through `blink.compat` — see the `providers.calc` entry in `lua/plugins/completion.lua` for the pattern (`module = "blink.compat.source"`). Use this shim rather than searching for a native blink source when one doesn't exist.

## Plugin file conventions

Files under `lua/plugins/` return either a single lazy spec (table) or a list of specs. Grouping is by concern, not one-plugin-per-file: `git.lua` holds gitsigns + diffview + neogit, `coding.lua` holds trouble + mini.pairs + mini.ai + ts-comments + sidekick, etc. When adding a plugin, extend the topically appropriate file rather than creating a new one unless the concern is genuinely new.
