-- colorscheme setup
vim.cmd([[
	colorscheme kanagawa
	hi Normal guibg=NONE ctermbg=NONE
]])



-- commentary setup
nmap("<Space>", ":Commentary<CR>")
vmap("<Space>", ":Commentary<CR>")



-- fugitive setup
nmap("<Leader>g", ":Git<CR>")
nmap("gdh", ":diffget //2<CR>")
nmap("gdl", ":diffget //3<CR>")



-- tagbar setup
nmap("t", ":TagbarToggle<CR>")



-- files exploring
map("n", "<C-P>", ":Telescope find_files<CR>", {})
map("n", "<C-F>", ":Telescope live_grep<CR>", {})
map("n", "<Leader>tb", ":Telescope buffers<CR>", {})

map("n", "<C-I>", ":NeoTreeFloatToggle<CR>", {})



-- glow setup
nmap("<Leader>m", ":Glow<CR>")
require('glow').setup({
	style = "dark",
	width = 220,
})



-- lsp setup
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "pyright", "rust_analyzer", "lua_ls" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	}
end


-- use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gs", function()
			vim.cmd("vsplit")
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<C-L>", function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})



-- lsp cmp setup
local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-K>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
}



-- null_ls setup
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- Python
		null_ls.builtins.formatting.black.with({ filetypes = { "python" } }),
		null_ls.builtins.formatting.isort.with({ filetypes = { "python" } }),
		-- frontend
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "html", "css", "javascript", "typescript", "json", "yaml", "markdown" },
		}),
	},
})
