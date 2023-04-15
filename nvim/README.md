# NVIM parfeniukink configuration

✅ This folder represent the NVIM configuration setup for working with:

- Python
- Rust
- Lua
- JS/TS
- HTML/CSS

<br>

## 🔌 The setup is powered by:

- [Lua](https://www.lua.org)
- [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager
- [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) files manager
- [kanagawa](https://github.com/rebelot/kanagawa.nvim) colorscheme
- [tagbar](https://github.com/preservim/tagbar)
- [csv preview](https://github.com/chrisbra/csv.vim)
- [Glow](https://github.com/ellisonleao/glow.nvim) markdown preview tool
- [vim-commentary](https://github.com/tpope/vim-commentary)
- [telescope](https://github.com/nvim-telescope/telescope.nvim) searching tool
- Git tools
  - [gitgutter](https://github.com/airblade/vim-gitgutter)
  - [fugitive](https://github.com/tpope/vim-fugitive)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) with all following adds for autocomplete:
  - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
  - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
  - [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
  - [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) tool to extend formatting especially

<br>

## ⬇️ Requirements

<br>

<b><u>Language servers</b></u>

Python

```bash
brew instal pyright
```

Rust

⚠️ add to the PATH: `$(rustup which rust-analyzer)`

```bash
rustup component add rust-analyzer
```

Lua

```bash
brew install lua-language-server
```

<br>

<b><u>Formatters</b></u>

```bash
pip install black isort
brew install prettier
```

<br>

<b><u>Other tools</b></u>

```bash
brew install node
brew install yarn
brew install glow
```

<br>

🔗 For proper icons preview download [NERD fonts](https://www.nerdfonts.com)
