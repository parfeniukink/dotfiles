-- ===================================================================
-- colorscheme setup
-- ===================================================================
vim.cmd([[
	colorscheme kanagawa-wave

    hi DiagnosticError guifg=#DB4A6A
    hi DiagnosticWarn  guifg=#DB794A
    hi DiagnosticInfo  guifg=#4AA7DB
    hi DiagnosticHint  guifg=#4ADBA0
    hi DiagnosticErrorSign guifg=#DB4A6A
    hi DiagnosticWarnSign  guifg=#DB794A
    hi DiagnosticInfoSign  guifg=#4AA7DB
    hi DiagnosticHintSign  guifg=#4ADBA0
]])

local signs = { Error = "🚨", Warn = "⚠️", Hint = "💡", Info = "ℹ️" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        source = "always",
        prefix = '●',
    },
    severity_sort = true,
    float = {
        source = "always",
    },
})


-- Treesitter configuration
local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
        "tsx",
        "toml",
        "json",
        "yaml",
        "swift",
        "css",
        "html",
        "lua",
        "javascript",
        "python",
        "rust",
    },
    autotag = {
        enable = true,
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }


-- ===================================================================
-- commentary setup
-- ===================================================================
nmap("<Space>", ":Commentary<CR>")
vmap("<Space>", ":Commentary<CR>")



-- ===================================================================
-- Git setup
-- ===================================================================

-- fugitive
nmap("<Leader>g", ":Git<CR>")
nmap("<Leader>c", ":Git commit -v<CR>")
nmap("gdh", ":diffget //2<CR>")
nmap("gdl", ":diffget //3<CR>")

-- git signs
require('gitsigns').setup {}


-- ===================================================================
-- tagbar setup
-- ===================================================================
nmap("t", ":TagbarToggle<CR>")


-- ===================================================================
-- telescope setup
-- ===================================================================
require('telescope').setup {
    defaults = {
        file_ignore_patterns = { "node_modules", "venv" }
    }
}
map("n", "<C-P>", ":Telescope find_files<CR>", {})
map("n", "<C-F>", ":Telescope live_grep<CR>", {})
map("n", "<Leader>tb", ":Telescope buffers<CR>", {})

map("n", "<C-I>", ":NeoTreeFloatToggle<CR>", {})




-- auto-pairs setup
-- require("nvim-autopairs").setup {
--     disable_filetype = { "TelescopePrompt", "vim" },
-- }



-- ===================================================================
-- LSP setup
-- ===================================================================
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()


-- lua configuration
-- -------------------------------------------------------------------
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        print("Attached to the LUA")
        vim.keymap.set("n", "<C-L>", function()
            vim.lsp.buf.format { async = true }
            print("🧹 Formatting finished")
        end, opts)
    end,
    filetypes = { "lua" },
})


-- python configuration
-- -------------------------------------------------------------------
lspconfig.pyright.setup({
    capabilities = capabilities
})


-- javascript / typescript configuration
-- -------------------------------------------------------------------

lspconfig.tsserver.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        print("Attached to the LUA")
        vim.keymap.set("n", "<C-L>", function()
            vim.lsp.buf.format { async = true }
            print("🧹 Formatting finished")
        end, opts)
    end,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
})


-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
-- 	callback = function(ev)
-- 		-- Buffer local mappings.
-- 		-- See `:help vim.lsp.*` for documentation on any of the below functions
-- 		local opts = { buffer = ev.buf }
-- 		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
-- 		vim.keymap.set("n", "gs", function()
-- 			vim.cmd("vsplit")
-- 			vim.lsp.buf.definition()
-- 		end, opts)
-- 		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- 		vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
-- 		vim.keymap.set("n", "<C-L>", function()
-- 			vim.lsp.buf.format { async = true }
-- 			print("🧹 Formatting finished")
-- 		end, opts)
-- 	end,
-- })


-- Restart the lsp key binding
nmap("<S-E>", ":LspRestart<CR>")


-- ===================================================================
-- Additional LSP enhancement tools
-- ===================================================================

-- lsp saga
-- -------------------------------------------------------------------
local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup({
    ui = {
        winblend = 10,
        border = 'rounded',
        colors = {
            normal_bg = '#002b36'
        }
    },
    symbol_in_winbar = {
        enable = true
    }
})


local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

-- code action
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")


-- lsp cmp / luasnip
-- -------------------------------------------------------------------
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



-- null_ls
-- -------------------------------------------------------------------
local null_ls = require("null-ls")
null_ls.setup({
    debug = false,
    sources = {
        -- Python
        null_ls.builtins.formatting.black.with(
            {
                filetypes = { "python" },
                extra_args = { "--fast" }
            }
        ),

        null_ls.builtins.formatting.isort.with({ filetypes = { "python" } }),
        -- frontend
        null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "html",
                "css",
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "json",
                "yaml",
                "markdown",
            },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" }
        }),
    },
})
