# NVIM parfeniukink configuration

References (_VIM as IDE_):

- 🔗 [LunarVIM](https://www.lunarvim.org)
- 🔗 [LazyVIM](https://www.lazyvim.org)

<br>

_This configuration is clean and simple in order to keep the transparency of all the processes in your editor_

This folder represent the NVIM configuration setup for working with:

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
- [GitHub Copilot](https://github.com/github/copilot.vim) autocomplete tool

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

## Installation

1. Download this fodler to your Desktop
2. Copy it to the nvim configuration folder

⚠️ Since this folder is used for the lazy.nvim setup it is mandatory to use this folder as a primary place for your configuration

```bash
cp ~/Desktop/nvim ~/.config/
```


## GitHub Copilot setup
⚠️ Once you enter this command in NVIM editor you will receive the code you have to enter in the browser after pressing Enter

```
:Copilot auth
```

