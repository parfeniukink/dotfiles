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
    ensure_installed = { "lua", "markdown", "markdown_inline", "yaml", "toml", "python", "javascript", "svelte", "typescript" },
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
-- harpoon setup
-- ===================================================================
local harpoon = require "harpoon"
harpoon:setup({
    settings = {
        save_on_toggle = true
    }
})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>w", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>r", function() harpoon:list():next() end)
vim.keymap.set("n", "<leader>\\", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)


-- ===================================================================
-- todo-comments setup
-- ===================================================================
require("todo-comments").setup(
    {
        keywords = {
            FIX = {
                icon = " ", -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fix", "bug" }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = " ", color = "info", alt = { "todo" } },
            HACK = { icon = " ", color = "warning", alt = { "hack" } },
            WARNING = { icon = " ", color = "warning", alt = { "warning" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "perf" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO", "note" } },
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED", "test" } },
        }
    }
)



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
map("n", "<Leader>pr", ":Gitsigns preview_hunk<CR>", {})



-- ===================================================================
-- tagbar setup
-- ===================================================================
nmap("t", ":TagbarToggle<CR>")



-- ===================================================================
-- telescope setup
-- ===================================================================
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local largeFilesIgnoringPreviewer = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 100000 then
            return
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end

require('telescope').setup {
    defaults = {
        wrap_results = true,
        file_ignore_patterns = { "node_modules", ".git/", "build", "ios", "macos", "__pycache__", "venv", ".env" },
        buffer_previewer_maker = largeFilesIgnoringPreviewer,
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
    },

    pickers = {
        oldfiles = { initial_mode = "normal", sorter = sorters.fuzzy_with_index_bias() },
        command_history = { sorter = sorters.fuzzy_with_index_bias() },
        find_files = { hidden = true, },
        git_files = { show_untracked = true, wrap_results = true }
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('plugins.telescope.multigrep').setup()

map("n", "<C-P>", ":Telescope find_files<CR>", {})
-- note: replaced with multigrep in plugins.telescope.multigrep
-- map("n", "<C-F>", ":Telescope live_grep<CR>", {})



-- ===================================================================
-- netrw setup
-- ===================================================================
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.7  -- You can change this too

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
    filters = {
        dotfiles = false,
    },
    renderer = {
        hidden_display = "none", -- none, simple, all
        indent_width = 4,
        -- highlight_git = "none",
        -- highlight_diagnostics = "none",
        -- highlight_opened_files = "none",
        -- highlight_modified = "none",
        -- highlight_hidden = "none",
        -- highlight_bookmarks = "none",
        -- highlight_clipboard = "name",
    }
})

map("n", "<C-I>", ":NvimTreeFindFileToggle<CR>", {})



-- ===================================================================
-- LSP setup
-- ===================================================================
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "pyright", "svelte" }
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
    severity_sort = true,
    update_in_insert = false,

    signs = true,
    underline = false,
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
    settings = {
        python = {
            disableOrganizeImports = false,
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = false,   -- extract types if not provided
                diagnosticMode = "openFilesOnly", -- enum { openFilesOnly, workspace }
                typeCheckingMode = "basic"        -- enum { basic, strict, off }
            }
        }
    }
})

-- lspconfig.ruff.setup({
--     on_attach = lsp_on_attach,
--     init_options = {
--         settings = {
--             -- Any extra CLI arguments for `ruff` go here.
--             args = {},
--         }
--     }
-- })


-- lspconfig.gopls.setup({
--     on_attach = lsp_on_attach,
--     filetypes = { "go", "gomod" },
-- })



lspconfig.ts_ls.setup({
    on_attach = lsp_on_attach,
    filetypes = { "javascript", "typescript", "typescriptreact", "css" },
})
lspconfig.tailwindcss.setup({
    on_attach = lsp_on_attach,
    filetypes = { "html", "css", "javascript", "typescript", "typescriptreact", "svelte" },
})

lspconfig.svelte.setup({
    on_attach = lsp_on_attach,
    filetypes = { "svelte", "svelte.ts", "css" },
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

lspconfig.dartls.setup({
    on_attach = lsp_on_attach,
    settings = {
        dart = {
            analysisExcludedFolders = {
                vim.fn.expand("/opt/homebrew"),
                vim.fn.expand("$HOME/.pub-cache"),
                vim.fn.expand("$HOME/flutter"),
            }
        }
    }
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
    float = {
        source = "always", -- Or "if_many"
    },
})




-- conform
-- -------------------------------------------------------------------
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        go = { "gofmt" },
        python = { "isort", "black" },
        dart = { "dart_format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        sql = { "sqlfmt" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },

    },
    format_on_save = nil,
    --     async = false,
    --     timeout_ms = 100,
    --     lsp_fallback = true
    -- },
    notify_on_error = true,

})

vim.keymap.set("n", "<C-L>", function()
    conform.format({
        async = true,
        timeout_ms = 200,
        lsp_fallback = true,
    })
end, {})


-- codecompanion
-- -------------------------------------------------------------------
require("codecompanion").setup({
    prompt_library = {
        ["Documentation Generation"] = {
            strategy = "chat",
            description = "Documentation Generation",
            opts = {
                ignore_system_prompt = true,
            },
            references = {
                {
                    type = "file",
                    path = { -- This can be a string or a table of values
                        "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/references/docstrings.py",
                    },
                },
            },
            prompts = {
                {
                    role = "system",
                    content = [[
                        You are an AI documentation assistant named "DmytroDocs".
                        You are integrated with Neovim on a user's machine.

                        Your core tasks include:
                        - Generating clear, concise documentation for code snippets or full buffers.
                        - Writing explanations for functions, classes, and modules.
                        - Creating usage examples.
                        - Following common documentation standards (e.g., docstrings, markdown).
                        - Ensuring documentation is easy to understand.

                        You must:
                        - Follow user instructions carefully.
                        - Use Markdown formatting for outputs.
                        - Avoid unnecessary verbosity.
                        - Provide only relevant code or text without extra markup.
                        - Use actual line breaks instead of '\n' for new lines.

                        When given a task:
                        1. Read the code thoroughly.
                        2. Generate appropriate documentation.
                        3. Format it properly for the user's context.
                    ]]
                },
                {
                    role = "user",
                    content = "Generate the documentation, based on the code I provided to you."
                }
            },
        },
        ["Commit Message"] = {
            strategy = "chat",
            description = "Commit Message",
            opts = {
                ignore_system_prompt = true,
            },
            references = {
                {
                    type = "file",
                    path = { -- This can be a string or a table of values
                        "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/commit/quick_fix.txt",
                        "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/commit/feature_implementation.txt",
                        "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/commit/refactoring.txt",
                    },
                },
            },
            prompts = {
                {
                    role = "system",
                    content = [[
                        You are an AI documentation assistant named "DmytroCommit".
                        You are integrated with Neovim on a user's machine.

                        Your core tasks include:
                        - Reading Git diffs to understand the context of changes, made by human
                        - Generating clear, easy-to-read commit messages for pull requests and git history
                        - Additionaly correct spelling in made changes to prevent grammar mistakes

                        You must:
                        - Follow user instructions carefully.
                        - Use Markdown formatting for outputs.
                        - Avoid unnecessary verbosity.
                        - Provide the output only in way that is defined in provided references
                    ]]
                },
                {
                    role = "user",
                    content = "Generate the commit messages, based on the diff I provided to you."
                }
            },
        },
        ["Unit Test"] = {
            strategy = "chat",
            description = "Unit/Integration Test Generation",
            opts = {
                ignore_system_prompt = true,
            },
            prompts = {
                {
                    role = "system",
                    content = [[
                        You are an AI tests assistant named "DmytroTest".
                        You are integrated with Neovim on a user's machine.

                        Your core tasks include:
                        - Generating clear test cases, based on some example
                        - Generating clear test cases, in thin functions, using pytest if no examples provided

                        You must:
                        - Output only the code according to the context
                        - Prefer docstrings instead of comments
                        - Avoid unnecessary verbosity.
                        - Use actual line breaks instead of '\n' for new lines.

                    ]]
                },
                {
                    role = "user",
                    content = "Generate the test case, based on the code I provided to you."
                }
            },
        },
        ["Teacher Homework Reviewer"] = {
            strategy = "chat",
            description = "Teacher Homework Reviewer",
            opts = {
                ignore_system_prompt = true,
            },
            prompts = {
                {
                    role = "system",
                    content = [[
                        You are an AI assistant for reviewing student's homeworks.
                        You are integrated with Neovim on a user's machine.

                        Your core tasks include:
                        - Analyze the homework task for further homework review
                        - Analyze the homework itself to provide the feedback for student
                        - Generating clean, without extra verbose replies which will allow student to fix the issue

                        You must:
                        - Not directly provide the answer for student
                        - Include function names to specify directly where is the problem but not fix it
                        - Not care if student adds extra job in homework. It is good
                        - Help studen't to understand what is the issue
                        - Include official documentation / trusted resources links for references if possible
                        - Include recommendations even if the homework is good and working to boost student
                        - Include the mark for the homewok from 0 to 100 and include in your response as separate information block in the end
                        - Use actual line breaks instead of '\n' for new lines.

                        The Task always goes first, then student's files below, and then, the language of the response.
                    ]]
                },
                {
                    role = "user",
                    content = "TASK:\n\n\nHOMEWORK:"
                }
            },
        },
    },
    opts = {
        system_prompt = function(opts)
            return [[
               You are an AI programming assistant named "Dmytro2.0".
               You are currently plugged in to the Neovim text editor on a user's machine.

                Your core tasks include:
                - Answering general programming questions.
                - Explaining how the code in a Neovim buffer works.
                - Reviewing the selected code in a Neovim buffer.
                - Proposing fixes for problems in the selected code.
                - Proposing relevant improvements if you have enough information.
                - Finding relevant code to the user's query.
                - Generating unit tests for the selected code.
                - Proposing fixes for test failures.
                - Answering questions about Neovim.

                You must:
                - Follow the user's requirements carefully and to the letter.
                - Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
                - Minimize other prose.
                - Use Markdown formatting in your answers.
                - Avoid including line numbers in code blocks.
                - Avoid wrapping the whole response in triple backticks.
                - Only return code that's relevant to the task at hand. You may not need to return all of the code that the user has shared.
                - Use actual line breaks instead of '\n' in your response to begin new lines.
                - Use '\n' only when you want a literal backslash followed by a character 'n'.
                - All non-code responses must be in %s.

                When given a task:
                1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail, unless asked not to do so.
                2. Output the code in a single code block, being careful to only return relevant code.
                3. You should always generate short suggestions for the next user turns that are relevant to the conversation.
                4. You can only give one reply for each conversation turn.
            ]]
        end,
    },
    adapters = {
        openai = function()
            return require("codecompanion.adapters").extend("openai", {
                env = {
                    url = "https://api.openai.com/v1/",
                    api_key = os.getenv("OPENAI__API_KEY"),
                    chat_url = "/chat/completions",
                    models_endpoint = "/models",
                },
                schema = {
                    model = {
                        default = os.getenv("OPENAI__MODEL"),
                    },
                    temperature = {
                        order = 2,
                        mapping = "parameters",
                        type = "number",
                        optional = true,
                        default = 0.8,
                        desc = "0.8 - random, 0.2 - deterministic.",
                        validate = function(n)
                            return n >= 0 and n <= 2, "Must be between 0 and 2"
                        end,
                    },
                    max_completion_tokens = {
                        order = 3,
                        mapping = "parameters",
                        type = "integer",
                        optional = true,
                        default = nil,
                        desc = "An upper bound for the number of tokens that can be generated for a completion.",
                        validate = function(n)
                            return n > 0, "Must be greater than 0"
                        end,
                    },
                    stop = {
                        order = 4,
                        mapping = "parameters",
                        type = "string",
                        optional = true,
                        default = nil,
                        desc =
                        "When this pattern is encountered the LLM will stop generating text and return. Multiple stop patterns may be set by specifying multiple separate stop parameters in a modelfile.",
                        validate = function(s)
                            return s:len() > 0, "Cannot be an empty string"
                        end,
                    },
                    logit_bias = {
                        order = 5,
                        mapping = "parameters",
                        type = "map",
                        optional = true,
                        default = nil,
                        desc =
                        "Modify the likelihood of specified tokens appearing in the completion. Maps tokens (specified by their token ID) to an associated bias value from -100 to 100. Use https://platform.openai.com/tokenizer to find token IDs.",
                        subtype_key = {
                            type = "integer",
                        },
                        subtype = {
                            type = "integer",
                            validate = function(n)
                                return n >= -100 and n <= 100, "Must be between -100 and 100"
                            end,
                        },
                    },
                },
            })
        end,
    },

    display = {
        action_palette = {
            show_default_prompt_library = false
        },
        inline = {
            layout = "vertical", -- vertical|horizontal|buffer
        },
    },
    strategies = {
        chat = {
            adapter = "openai"
        },
        inline = {
            keymaps = {
                accept_change = {
                    modes = { n = "<leader>k" },
                    description = "Accept the suggested change",
                },
                reject_change = {
                    modes = { n = "<leader>l" },
                    description = "Reject the suggested change",
                },
            },
        },
    },
})

nmap("<leader>i", ":CodeCompanionChat<CR>")
nmap("<leader>2", ":CodeCompanionAction<CR>")
vmap("<leader>2", ":CodeCompanionAction<CR>")
vmap("<leader>3", ":CodeCompanionChat add<CR>")


-- huggingface/llm.nvim
-- -------------------------------------------------------------------
-- local llm = require('llm')

-- llm.setup({
--     api_token = os.getenv("OPENAI__API_KEY"),
--     model = os.getenv("OPENAI__MODEL") or "gpt-4o-mini",
--     backend = "openai", -- huggingface | ollama | openai | tgi
--     url = "https://api.openai.com/v1/chat/completions",
--     messages = {
--         { role = "system", content = "You are simple code assistant. Provide autocompletion without overhead, based on the content" },
--     },
--     request_body = {
--         parameters = {
--             temperature = 0.2,
--             top_p = 0.95,
--             max_tokens = 250
--         },
--     },
--     accept_keymap = "<leader>\\",
--     dismiss_keymap = "<leader>a",

--     context_window = 1024,

--     -- manual mode
--     enable_suggestions_on_startup = true,
--     enable_suggestions_on_files = "*",
-- })


-- todo-list.nvim
-- -------------------------------------------------------------------
-- highlights list
map("n", "<leader>h", "<cmd>TodoTelescope<CR>", {})



-- centerpad.nvim
-- -------------------------------------------------------------------
map('n', '<leader>z', '<cmd>Centerpad<cr>', { silent = true, noremap = true })


require("gruvbox").setup({
    terminal_colors = true,
    undercurl = false,
    underline = false,
    bold = false,
    italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,    -- invert background for search, diffs, statuslines and errors
    contrast = "soft", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
})

vim.cmd([[
    colorscheme gruvbox
    set background=dark
]])


-- vim.g.PaperColor_Theme_Options = {
--     theme = {
--         default = {
--             transparent_background = 1,
--         },
--     },
-- }
-- vim.cmd("colorscheme PaperColor")
-- vim.cmd("set background=light")

-- apply background transparency for themes which don't support those
-- vim.cmd([[
--     hi NormalFloat ctermbg=NONE guibg=NONE
--     hi NormalNC ctermbg=NONE guibg=NONE
--     hi Normal ctermbg=NONE guibg=NONE
-- ]])
