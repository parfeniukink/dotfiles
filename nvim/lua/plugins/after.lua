-- ===================================================================
-- colorscheme setup
-- ===================================================================
vim.api.nvim_command([[
    hi DiagnosticError guifg=#E47D75
    hi DiagnosticWarn  guifg=#DB794A
    hi DiagnosticInfo  guifg=#4AA7DB
    hi DiagnosticHint  guifg=#4ADBA0
    hi DiagnosticErrorSign guifg=#DB4A6A
    hi DiagnosticWarnSign  guifg=#DB794A
    hi DiagnosticInfoSign  guifg=#4AA7DB
    hi DiagnosticHintSign  guifg=#4ADBA0

    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NormalFloat ctermbg=NONE guibg=NONE
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
        -- "tsx",
        -- "toml",
        -- "json",
        -- "yaml",
        -- "swift",
        -- "css",
        -- "html",
        -- "lua",
        -- "javascript",
        -- "python",
        -- "rust",
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
map("n", "gn", ":Gitsigns next_hunk<CR>", {})
map("n", "gp", ":Gitsigns prev_hunk<CR>", {})
map("n", "<Leader>pr", ":Gitsigns preview_hunk_inline<CR>", {})



-- ===================================================================
-- tagbar setup
-- ===================================================================
nmap("t", ":TagbarToggle<CR>")



-- ===================================================================
-- telescope setup
-- ===================================================================
require('telescope').setup {
    defaults = {
        file_ignore_patterns = { "node_modules", "venv", ".git" }
    }
}
map("n", "<C-P>", ":Telescope find_files<CR>", {})
map("n", "<C-F>", ":Telescope live_grep<CR>", {})
map("n", "<C-D>", ":Telescope diagnostics<CR>", {})



-- ===================================================================
-- netrw setup
-- ===================================================================
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

require('nvim-tree').setup({
    view = {
        float = {
            enable = true,
            open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * WIDTH_RATIO
                local window_h = screen_h * HEIGHT_RATIO
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2)
                    - vim.opt.cmdheight:get()
                return {
                    border = 'rounded',
                    relative = 'editor',
                    row = center_y,
                    col = center_x,
                    width = window_w_int,
                    height = window_h_int,
                }
            end,
        },
        width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
    },
})

map("n", "<C-I>", ":NvimTreeFindFileToggle<CR>", {})



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

-- dart / flutter configuration
-- -------------------------------------------------------------------
lspconfig.dartls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<C-L>", function()
            vim.lsp.buf.format { async = true }
            print("🧹 Formatting finished")
        end, opts)
        -- override default settings
        nmap("t", ":FlutterOutlineToggle<CR>")
        vim.cmd([[
        autocmd FileType dart set tabstop=2 shiftwidth=2 expandtab
    ]])
    end,
    filetypes = { "dart" },
})

require("flutter-tools").setup({})


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


-- golang configuration
-- -------------------------------------------------------------------
lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<C-L>", function()
            vim.lsp.buf.format { async = true }
            print("🧹 Formatting finished")
        end, opts)
    end,
    filetypes = { "go" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
})


-- TypeScript / tailwind configuration
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

-- code action
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")


-- lsp cmp
-- -------------------------------------------------------------------
local cmp = require("cmp")

cmp.setup {
    mapping = cmp.mapping.preset.insert({
        ["<C-K>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
    },
}



-- conform
-- -------------------------------------------------------------------
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        python = { "isort", "black" },
        html = { "prettier" },
        css = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" }

    },
    format_on_save = {
        async = false,
        timeout_ms = 500
    }

})

vim.keymap.set("n", "<C-L>", function()
    print("🧹 Formatting finished")
    conform.format({
        async = false,
        timeout_ms = 500
    })
end, {})



-- GitHub Copilot
-- -------------------------------------------------------------------
vim.g.copilot_no_tab_map = true
-- this line is mandatory
vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.g.copilot_filetypes = {
    ["*"] = false,
    ["lua"] = true,
    ["javascript"] = true,
    ["typescript"] = true,
    ["typescriptreact"] = true,
    ["c"] = true,
    ["c++"] = true,
    ["go"] = true,
    ["rust"] = true,
    ["swift"] = true,
    ["dart"] = true,
    ["python"] = true,
    ["dockerfile"] = true,
    ["compose"] = true,
}



-- rest.nvim
-- -------------------------------------------------------------------
map("n", "<leader>re", "<cmd>lua require('rest-nvim').run()<CR>", {})


-- todo-list.nvim
-- -------------------------------------------------------------------
map("n", "<leader>t", "<cmd>TodoTelescope<CR>", {})


-- ===================================================================
-- Set a theme here in order to apply the transparency after all the plugins are loaded
-- ===================================================================
vim.api.nvim_command("colorscheme nightfox")

-- Change nvim active tab to green
vim.api.nvim_command("hi TabLineSel guibg=#2d5748 guifg=#e5e5e5")
