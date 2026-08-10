# AGENTS.md

Personal dotfiles. Managed with GNU **stow**. Each top-level dir is a stow
package whose inner tree mirrors `$HOME` (e.g. `nvim/.config/nvim/` →
`~/.config/nvim/`). Editing a file here changes the symlinked target in `$HOME`.

## Layout / packages

- `install` — bootstrap script. Installs apps (brew/apt/nix), clones zsh + tmux
  plugins, runs `stow zsh nvim bin oh-my-zsh config`. Entry point; start here to
  understand what lands where.
- `zsh/.zshrc` — shell config, oh-my-zsh setup, plugin list, aliases.
- `oh-my-zsh/.oh-my-zsh/themes/cv.zsh-theme` — custom prompt theme.
- `bin/.local/bin/` — standalone shell scripts (`chuck-format`, `make-exec`,
  `stash`). One file per command, each a self-contained bash/zsh script.
- `config/.config/` — per-app config, one subdir per tool: `alacritty`,
  `ghostty`, `tmux` (`tmux.conf`), `yazi`, `ranger`, `mutt`, `fzf`, `ripgrep`,
  `lua`. Plain config files, no shared code.
- `nvim/.config/nvim/` — Neovim config (see below).
- `git/` — git config fragments (not stowed by `install`).

## Neovim (largest domain)

- `init.lua` — loads `options`, `lazy-init`, `commands`, `keymap`, `cmd-height`.
- `lua/lazy-init.lua` — bootstraps lazy.nvim, `require('lazy').setup('plugins')`.
- `lua/plugins/` — plugin specs. `init.lua` holds inline specs split into
  `alwaysOn` (also load under vscode) vs `notVsCode`; larger plugins get their
  own file (`avante.lua`, `coc.lua`, `fzf.lua`, `neotree.lua`,
  `nvim-treesitter.lua`, etc.) returning a lazy spec table.
- `lua/options.lua`, `lua/keymap.lua`, `lua/commands.lua` — settings, mappings,
  user commands.
- `lua/utils/` — shared Lua helpers, one module per file returning a table.
  `functional.lua` is the big one (map/filter/concat/forEach…) used across
  configs; others wrap buffer/events/tmux/log/timer concerns.
- `ftplugin/zig.lua` — filetype-specific settings.
- `coc-settings.json`, `lazy-lock.json` — LSP (coc.nvim) config and pinned
  plugin versions.

## Theming (Catppuccin Frappé, scattered)

No central theme file — the same Catppuccin Frappé palette
(`base=#303446`, `text=#c6d0f5`, etc.) is duplicated per tool:

- `oh-my-zsh/.oh-my-zsh/themes/cv.zsh-theme` — remaps the terminal's 16-color
  ANSI palette to Frappé via base16-shell escape codes. Other TUIs (mutt, tmux
  partials) reference colors by index (`color12`, `colour252`), so they inherit
  from here.
- `config/.config/tmux/tmux.conf` — defines Frappé hex vars (`crust`, `surface2`,
  `green`…) at ~line 84, then uses them for status/pane/border styles.
- `config/.config/ghostty/config` — `background = 303446` + Nerd Font; light
  variant commented out.
- `config/.config/alacritty/alacritty.toml` — `[colors]` Frappé bg/fg.
- `config/.config/fzf/theme.sh` — `FZF_DEFAULT_OPTS` Frappé `--color`; sourced by
  shell. `base16-ocean.config` is an alternate/unused palette.
- `config/.config/mutt/muttrc.theme` — colors by ANSI index (inherits omz map).
- `nvim/.config/nvim/lua/plugins/catppuccin.lua` — `catppuccin_flavour='frappe'`.
- `config/.config/yazi/theme.toml` — Frappé flavor block currently commented out.

To retheme, update each file; `latte` (light) variants are commented in most.

## tmux ↔ ghostty (keys / escape sequences)

The only coupling between the two is keyboard input; ghostty just feeds bytes to
tmux. `config/.config/ghostty/config` has a `# tmux` block that maps ergonomic
Ctrl chords to tmux prefix sequences: it emits `\x00` (NUL = `C-Space`, the tmux
prefix set in `tmux.conf`) followed by the key tmux binds. E.g. `ctrl+/` →
`\x00/` triggers the `bind /` horizontal split, `ctrl+-` → `\x00-` the `bind -`
vertical split, `ctrl+.`/`ctrl+,` → `\x00>`/`\x00<` (swap window next/prev),
`ctrl+;` → `\x00:` (`bind ;` command-prompt), `ctrl+f` → `\x00f` (extrakto).
So changing the tmux prefix or those `bind` keys means updating the matching
ghostty `keybind` bytes, and vice versa. Unrelated to tmux, ghostty also maps
`ctrl+enter` → `\x1b[C\r` to accept zsh-autosuggestions.

## Conventions

- Never add files directly in `~`; add under the matching stow package tree.
- Lua utils: single-responsibility module per file, `return`ing its API.
- Plugin gets its own file in `lua/plugins/` once config grows; trivial ones stay
  inline in `plugins/init.lua`.
- Config uses tabs (see `.editorconfig`).
