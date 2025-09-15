require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "pyright", "svelte", "emmet_ls" }
})

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

lspconfig.lua_ls.setup {
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

lspconfig.pyright.setup({
    on_attach = lsp_on_attach,
    root_dir = function() return vim.loop.cwd() end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = false,   -- extract types if not provided
                diagnosticMode = "openFilesOnly", -- enum { openFilesOnly, workspace }
                typeCheckingMode = "basic"        -- enum { basic, strict, off }
            },
            disableOrganizeImports = false,
            debounce_text_changes = 300,
        }
    }
})

-- lspconfig.ruff.setup({
--     on_attach = lsp_on_attach,
--     init_options = {
--         settings = {
--             fixAll = true,
--             organizeImports = true,

--             -- 6. Whether to show syntax errors
--             showSyntaxErrors = false,
--             codeAction = {
--                 disableRuleComment = { enable = true },
--                 fixViolation = { enable = true },
--             },
--             lint = {
--                 enable = true,
--                 preview = true,
--                 select = { "E", "F" },
--             },
--             format = {
--                 preview = true
--             },
--             nativeServer = "on", -- force use of native language server
--             importStrategy = "fromEnvironment",
--         }
--     }
-- })


-- lspconfig.gopls.setup({
--     on_attach = lsp_on_attach,
--     filetypes = { "go", "gomod" },
-- })


lspconfig.ts_ls.setup({
    on_attach = lsp_on_attach,
    filetypes = { "javascript", "typescript", "typescriptreact", "html", "css" },
})

lspconfig.tailwindcss.setup({
    on_attach = lsp_on_attach,
    filetypes = { "html", "css", "javascript", "typescript", "typescriptreact" },
})

lspconfig.svelte.setup({
    on_attach = lsp_on_attach,
    filetypes = { "svelte", "svelte.ts" },
    settings = {
        svelte = {
            plugin = {
                svelte = {
                    enable = true,
                },
                typescript = {
                    enable = true,
                },
            },
        },
    },
})

lspconfig.emmet_ls.setup({
    on_attach = lsp_on_attach,
    filetypes = { "css", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact" },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- lspconfig.html.setup {
--     init_options = {
--         configurationSection = { "html", "css", "javascript" },
--         embeddedLanguages = {
--             css = true,
--             javascript = true
--         },
--         provideFormatter = true
--     }
-- }

-- lspconfig.dartls.setup({
--     on_attach = lsp_on_attach,
--     settings = {
--         dart = {
--             analysisExcludedFolders = {
--                 vim.fn.expand("/opt/homebrew"),
--                 vim.fn.expand("$HOME/.pub-cache"),
--                 vim.fn.expand("$HOME/flutter"),
--             }
--         }
--     }
-- })

require("flutter-tools").setup {}

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
        { name = 'path' },
        { name = 'buffer' },
    }),
})


cmp.setup.filetype({ "sql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    },
})


-- diagnostic
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
    signs = true,
    underline = false,
    float = {
        source = "always",  -- Or "if_many"
        border = "rounded", -- or "single" | "double" | etc.
    },
})
