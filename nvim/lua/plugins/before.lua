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

    -- fzf
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
    },
    {
        "nvim-telescope/telescope.nvim",
        build = "make",
        branch = "master",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        }
    },

    -- colorschemes
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    { "ellisonleao/gruvbox.nvim",  priority = 1000, config = true, },
    { "rebelot/kanagawa.nvim" },
    { "NLKNguyen/papercolor-theme" },

    -- better tabs
    {
        "nanozuki/tabby.nvim",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },

    -- harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- colorize:
    -- todo:
    -- fix:
    -- hack:
    -- note:
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },

    },

    -- markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown", "mermaid" }
        end,
        ft = { "markdown", "mermaid" },
    },

    -- center viewport if 1 buffer
    'smithbm2316/centerpad.nvim',

    -- smart comments
    "tpope/vim-commentary",

    -- git stuff
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    -- tag bar
    "majutsushi/tagbar",

    -- lsp
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    -- llm integration
    {
        "olimorris/codecompanion.nvim",
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
        },
    },

    -- formatting
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },

    -- svelte
    'leafOfTree/vim-svelte-plugin',

})
