-- ===================================================================
-- colorscheme setup
-- ===================================================================
vim.cmd([[
    hi DiagnosticError guifg=#E47D75
    hi DiagnosticWarn  guifg=#DB794A
    hi DiagnosticInfo  guifg=#4AA7DB
    hi DiagnosticHint  guifg=#4ADBA0
    hi DiagnosticErrorSign guifg=#DB4A6A
    hi DiagnosticWarnSign  guifg=#DB794A
    hi DiagnosticInfoSign  guifg=#4AA7DB
    hi DiagnosticHintSign  guifg=#4ADBA0

    hi NormalFloat ctermbg=NONE guibg=NONE
    hi NormalNC ctermbg=NONE guibg=NONE
    hi Normal ctermbg=NONE guibg=NONE

]])


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
    ensure_installed = {},
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
                -- line.sep('', hl, theme.fill),
                line.sep('', hl, theme.fill),
                tab.is_current() and '' or '󰆣',
                tab.number(),
                tab.name(),
                tab.close_btn(''),
                -- line.sep('', hl, theme.fill),
                line.sep('', hl, theme.fill),
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
        file_ignore_patterns = { "node_modules", "venv", ".git", "build", "ios", "macos" }
    }
}
map("n", "<C-P>", ":Telescope find_files<CR>", {})
map("n", "<C-F>", ":Telescope live_grep<CR>", {})




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
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "tsserver", "ruff_lsp", "jedi_language_server", "gopls" }
})

local lspconfig = require('lspconfig')

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    severity_sort = true,
})

local lsp_on_attach = function(_, _)
    local opts = {}
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'de', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)

    vim.keymap.set('n', '<leader>rn', function()
            vim.lsp.buf.rename()
            -- save all buffers
            vim.cmd("silent! wa")
        end,
        opts)
end

vim.keymap.set('n', '<S-e>', ":LspRestart<CR>", {})

require("lspconfig").lua_ls.setup {
    on_attach = lsp_on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.stdpath "config" .. "/lua"] = true,
                },
            },
        },
    }
}

-- require("lspconfig").pyright.setup({
--     on_attach = lsp_on_attach,
--     filetypes = { "python" },
-- })

require("lspconfig").jedi_language_server.setup({
    on_attach = lsp_on_attach,
    init_options = {
        completion = {
            disableSnippets = true,
        },
    }
})

require("lspconfig").ruff_lsp.setup({
    on_attach = lsp_on_attach,
    init_options = {
        settings = {
            args = {
                "--extend-select=W,COM,ICN",
                "--ignore=E501,E722,COM812",
            },
        },
    },
})

require("lspconfig").gopls.setup({
    on_attach = lsp_on_attach,
    filetypes = { "go", "gomod" },
})
require("lspconfig").tsserver.setup({
    on_attach = lsp_on_attach,
    filetypes = { "javascript", "typescript", "typescriptreact" },
})
require("lspconfig").tailwindcss.setup({
    on_attach = lsp_on_attach,
    filetypes = { "html", "css", "javascript", "typescript", "typescriptreact" },
})

local cmp = require("cmp")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-p>'] = cmp.mapping.select_next_item(),
        ['<C-o>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    }),
})


-- Diagnostic
-- -------------------------------------------------------------------
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
    opts = opts or { ['lnum'] = line_nr }

    local line_diagnostics = vim.diagnostic.get(bufnr, opts)
    if vim.tbl_isempty(line_diagnostics) then return end

    local diagnostic_message = ""
    for i, diagnostic in ipairs(line_diagnostics) do
        diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
        -- print(diagnostic_message)
        if i ~= #line_diagnostics then
            diagnostic_message = diagnostic_message .. "\n"
        end
    end
    -- display after the delay
    -- vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
end

vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        source = "always", -- Or "if_many"
    },
})




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
        async = true,
        timeout_ms = 200,
        lsp_fallback = true
    },
    notify_on_error = true,

})

vim.keymap.set("n", "<C-L>", function()
    conform.format({
        async = true,
        timeout_ms = 200,
        lsp_fallback = true,
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



-- flutter tools
-- -------------------------------------------------------------------
require("flutter-tools").setup({})



-- Setup colorscheme
-- -------------------------------------------------------------------
require("catppuccin").setup({
    flavour = "macchiato",
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
            inlay_hints = {
                background = false,
            },
        },
    },
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false,        -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false,        -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15,      -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,          -- Force no italic
    no_bold = true,             -- Force no bold
    no_underline = false,       -- Force no underline
    custom_highlights = function(colors)
        return {
            NormalFloat = { fg = colors.text, bg = colors.grey },
            Comment = { bg = colors.none, fg = colors.grey },
            TabLineSel = { bg = colors.surface2, fg = colors.text },
            CmpBorder = { fg = colors.surface2 },
            Pmenu = { bg = colors.none },
        }
    end

})

vim.cmd.colorscheme "catppuccin"
