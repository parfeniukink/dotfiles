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
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim"
		}
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	-- colorscheme
	"rebelot/kanagawa.nvim",
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	},

	-- previews
	{
		'iamcco/markdown-preview.nvim',
		build = 'cd app && yarn install'
	},
	"chrisbra/csv.vim",


	-- smart comments
	"tpope/vim-commentary",

	-- git stuff
	"airblade/vim-gitgutter",
	"tpope/vim-fugitive",

	-- tag bar
	"majutsushi/tagbar",

	-- lsp
	"neovim/nvim-lspconfig",

	-- autocomplete
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"saadparwaiz1/cmp_luasnip",
	"L3MON4D3/LuaSnip",

	-- autopairs
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",

	-- formatting
	"jose-elias-alvarez/null-ls.nvim"
})
