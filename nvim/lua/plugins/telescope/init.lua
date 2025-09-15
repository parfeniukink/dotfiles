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
        file_ignore_patterns = { "**/node_modules/", "**/.git/", "**/ios/", "**/macos/", "**/build/", "**/__pycache__/", "**/venv/" },
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
        find_files = { hidden = true },
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

-- NOTE: setup multigrep command with <C-F>
require('plugins.telescope.multigrep').setup()

map("n", "<C-P>", ":Telescope find_files<CR>", {})
map("n", "<leader>r", ":Telescope git_status<CR>", {})

-- Telescope Todos
map("n", "<leader>h", "<cmd>TodoTelescope<CR>", {})
