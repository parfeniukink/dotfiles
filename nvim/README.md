# NVIM parfeniukink configuration

References (_VIM as IDE_):

- 🔗 [LunarVIM](https://www.lunarvim.org)
- 🔗 [LazyVIM](https://www.lazyvim.org)

<br>

_This configuration is clean and simple in order to keep the transparency of all the processes in your editor_

This folder represent the NVIM configuration setup for working with:

- Python
- Rust
- Golang
- Lua
- JS/TS
- HTML/CSS

<br>

## 🔌 The setup is powered by:

- [Lua](https://www.lua.org)
- [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager
- Previews
  - [nightfox](https://github.com/EdenEast/nightfox.nvim) colorscheme
  - [nvim-neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) files manager
  - [csv preview](https://github.com/chrisbra/csv.vim)
  - [markdown-preview](https://github.com/iamcco/markdown-preview.nvim) markdown preview tool
  - [todo-comments](https://github.com/folke/todo-comments.nvim) colorize comments
  - [tagbar](https://github.com/preservim/tagbar)
  - [telescope](https://github.com/nvim-telescope/telescope.nvim) searching tool
  - [harpoon](https://github.com/ThePrimeagen/harpoon) files explore tool -[tabby](https://github.com/nanozuki/tabby.nvim) better window tabs
- Git tools
  - [fugitive](https://github.com/tpope/vim-fugitive)
  - [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- Autocompletion & dev docs & suggestions \* code quality tools
  - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) with all following adds for autocomplete:
    - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
    - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
    - [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
    - [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
    - [lsp_saga](https://github.com/nvimdev/lspsaga.nvim) enchancement plugin
  - [copilot](https://github.com/features/copilot) Microsoft code AI tool
  - [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) extend LSP with formatting and other
- [vim-commentary](https://github.com/tpope/vim-commentary) smart comments with shortcut
- [rest](https://github.com/rest-nvim/rest.nvim) REST client via curl

<br>

## ⬇️ Requirements

<b><u>Treesitter parsers</b></u>

for lspsaga

```
:TSInstall markdown markdown_inline
```

for http client

```
:TSInstall json http
```

<b><u>Language servers</b></u>

Python

```bash
pip instal pyright
```

Golang

Install the 'Go please"

```bash
# Linux
go install golang.org/x/tools/gopls@latest

# MacOS
brew isntall gopls
```

⚠️ add to the `.zshrc` only on Linux:

```bash
export GOROOT=/usr/local/go
export GOPATH=~/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
```

Rust

⚠️ add to the PATH: `$(rustup which rust-analyzer)`

```bash
rustup component add rust-analyzer
```

Typescript

```bash
npm install -g typescript-language-server typescript
```

Tailwindcss

```bash
npm install -g @tailwindcss/language-server
```

Lua

```bash
# Ubuntu
sudo apt install lua5.3 ninja-build

git clone https://github.com/LuaLS/lua-language-server
cd lua-language-server
./make.sh

echo "export '/usr/local/bin/lua-language-server/bin:$PATH' >> ~/.zshrc"


# MacOS
brew install lua-language-server
```

<br>
<br>

<b><u>Formatters</b></u>

```bash
pip install black isort

# MacOS
brew install prettierd

## Ubuntu
npm install --save-dev --save-exact prettier
```

<br>

<b><u>Other tools</b></u>

```bash
brew install yarn
brew install glow
```

<br>
<br>

<b><u>OpenAI API Key</b></u>

🔗 [OpenAI API Keys](https://platform.openai.com/account/api-keys)

```bash
export OPENAI_API_KEY="change me"
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

## GitHub Copilot setup [optional]

⚠️ Once you enter this command in NVIM editor you will receive the code you have to enter in the browser after pressing Enter

```
:Copilot auth
```
