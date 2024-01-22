-- This module
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)


-- Check the lazy plugin manager
local ok, lazy = pcall(require, "lazy")

if not ok then
    print("Can not load the lazy plugins manager")
    return
end


-- Setup plugins
lazy.setup({
    -- files explore
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        }
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    "ThePrimeagen/harpoon",

    -- colorschemes
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    "EdenEast/nightfox.nvim",

    -- better tabs
    "nanozuki/tabby.nvim",

    -- colorize:
    -- TODO:
    -- FIX:
    -- HACK:
    -- NOTE:
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },

    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown", "mermaid" }
        end,
        ft = { "markdown", "mermaid" },
    },

    -- http client
    { "rest-nvim/rest.nvim" },

    -- smart comments
    "tpope/vim-commentary",

    -- git stuff
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    -- tag bar
    "majutsushi/tagbar",

    -- LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",

    -- GitHub Copilot
    -- "zbirenbaum/copilot.lua",
    "github/copilot.vim",

    -- formatting
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },

    -- flutter tools
    {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = true,
    }
})
