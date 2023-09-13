-- ===================================================================
-- colorscheme setup
-- ===================================================================
vim.cmd([[
	colorscheme nightfox

    hi DiagnosticError guifg=#E47D75
    hi DiagnosticWarn  guifg=#DB794A
    hi DiagnosticInfo  guifg=#4AA7DB
    hi DiagnosticHint  guifg=#4ADBA0
    hi DiagnosticErrorSign guifg=#DB4A6A
    hi DiagnosticWarnSign  guifg=#DB794A
    hi DiagnosticInfoSign  guifg=#4AA7DB
    hi DiagnosticHintSign  guifg=#4ADBA0

    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
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

vim.cmd([[
    if exists('+termguicolors')
      let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
]])

-- Treesitter configuration
local tssitter_status, ts = pcall(require, "nvim-treesitter.configs")
if (not tssitter_status) then return end

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
-- Tabby setup
-- ===================================================================
local theme = {
    fill = 'TabLineFill',
    -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
    head = 'TabLine',
    current_tab = 'TabLineSel',
    tab = 'TabLine',
    win = 'TabLine',
    tail = 'TabLine',
}
require('tabby.tabline').set(function(line)
    return {
        line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
                line.sep('', hl, theme.fill),
                tab.is_current() and '' or '󰆣',
                tab.number(),
                tab.name(),
                tab.close_btn(''),
                line.sep('', hl, theme.fill),
                hl = hl,
                margin = ' ',
            }
        end),
        line.spacer(),
        hl = theme.fill,
    }
end)



-- ===================================================================
-- todo-comments setup
-- ===================================================================
require("todo-comments").setup()



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

map("n", "<C-I>", ":Neotree position=float toggle<CR>", {})



-- ===================================================================
-- harpoon setup
-- ===================================================================
local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')

vim.keymap.set(
    "n", "<Leader>a", function() harpoon_mark.add_file() end, {}
)
vim.keymap.set(
    "n", "<Leader>r", function() harpoon_mark.rm_file() end, {}
)
vim.keymap.set(
    "n", "<Leader>z", function() harpoon_mark.clear_all() end, {}
)
vim.keymap.set(
    "n", "<Leader>w", function() harpoon_ui.toggle_quick_menu() end, {}
)
vim.keymap.set(
    "n", "<Leader>q", function() harpoon_ui.nav_prev() end, {}
)
vim.keymap.set(
    "n", "<Leader>e", function() harpoon_ui.nav_next() end, {}
)



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
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<C-L>", function()
            vim.lsp.buf.format { async = true }
            print("🧹 Formatting finished")
        end, opts)
    end,
    filetypes = { "python" },
})


-- javascript / typescript configuration
-- -------------------------------------------------------------------

lspconfig.tsserver.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<C-L>", function()
            vim.lsp.buf.format { async = true }
            print("🧹 Formatting finished")
        end, opts)
    end,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
})

lspconfig.tailwindcss.setup {}

-- Restart the lsp key binding
nmap("<S-E>", ":LspRestart<CR>")



-- ===================================================================
-- Additional LSP enhancement tools
-- ===================================================================

-- lsp saga
-- -------------------------------------------------------------------
local saga = require("lspsaga")

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
vim.keymap.set('n', 'de', '<Cmd>Lspsaga goto_definition<CR>', opts)
vim.keymap.set('n', '<leader>de', '<Cmd>Lspsaga finder<CR>', opts)
vim.keymap.set('n', '<leader>pe', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'dr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

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



-- GitHub Copilot
-- -------------------------------------------------------------------
vim.g.copilot_no_tab_map = true
-- this line is mandatory
vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.g.copilot_filetypes = {
    ["*"] = false,
    ["javascript"] = true,
    ["typescript"] = true,
    ["typescriptreact"] = true,
    ["c"] = true,
    ["c++"] = true,
    ["go"] = true,
    ["rust"] = true,
    ["python"] = true,
}



-- rest.nvim
-- -------------------------------------------------------------------
map("n", "<leader>re", "<cmd>lua require('rest-nvim').run()<CR>", {})
