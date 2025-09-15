-- fugitive
nmap("<Leader>g", ":Git<CR>")
nmap("<Leader>c", ":Git commit -v<CR>")
nmap("gdh", ":diffget //2<CR>")
nmap("gdl", ":diffget //3<CR>")

-- git signs
require('gitsigns').setup {
    signs                        = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged                 = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged_enable          = true,
    signcolumn                   = true,
    numhl                        = true,
    linehl                       = false,
    word_diff                    = false,
    watch_gitdir                 = {
        follow_files = true
    },
    auto_attach                  = true,
    attach_to_untracked          = false,
    current_line_blame           = true,
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 2000,
        ignore_whitespace = true,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 10000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
}
map("n", "gn", ":Gitsigns next_hunk<CR>", {})
map("n", "gp", ":Gitsigns prev_hunk<CR>", {})
map("n", "<Leader>pr", ":Gitsigns preview_hunk<CR>", {})

map("n", "<Leader>w", ":Gitsigns ", {})



-- Visual-mode: show Git history for the selected line range.
-- <leader>gl -> detailed patch (-p)
-- <leader>gL -> summary only (-s)

local function git_log_for_visual_selection(diff_mode)
    -- 1) File path
    local buf = vim.api.nvim_get_current_buf()
    local abs_path = vim.api.nvim_buf_get_name(buf)
    if abs_path == "" then
        vim.notify("No file associated with this buffer.", vim.log.levels.WARN)
        return
    end

    -- 2) Visual range (1-based)
    local vstart = vim.fn.getpos("v")[2]
    local vend   = vim.fn.getpos(".")[2]
    if vstart > vend then vstart, vend = vend, vstart end

    -- 3) Repo root + repo-relative path
    local file_dir = vim.fn.fnamemodify(abs_path, ":h")
    local toplevel = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "--show-toplevel" })[1]
    if not toplevel or toplevel == "" or toplevel:match("^fatal:") then
        vim.notify("Not a Git repo (or Git not found).", vim.log.levels.ERROR)
        return
    end
    local relpath_list = vim.fn.systemlist({ "git", "-C", toplevel, "ls-files", "--full-name", "--", abs_path })
    local relpath = relpath_list[1]
    if not relpath or relpath == "" then
        vim.notify("File is not tracked by Git (no history).", vim.log.levels.WARN)
        return
    end

    -- 4) Build git log command. IMPORTANT: -L only supports -p or -s.
    local range_spec = string.format("%d,%d:%s", vstart, vend, relpath)
    local diff_flag = diff_mode == "summary" and "-s" or "-p" -- default to patch
    local cmd = { "git", "-C", toplevel, "log", "--decorate", "--no-color", diff_flag, "-L", range_spec }

    local output = vim.fn.systemlist(cmd)
    if vim.v.shell_error ~= 0 then
        local msg = table.concat(output, "\n")
        vim.notify("git log failed:\n" .. msg, vim.log.levels.ERROR)
        return
    end
    if #output == 0 then
        vim.notify("No history for this range.", vim.log.levels.INFO)
        return
    end

    -- 5) Scratch buffer
    vim.cmd("vnew")
    local out_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(out_buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(out_buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(out_buf, "swapfile", false)
    local title = string.format("git-log(%s):%s:%d-%d", diff_flag, relpath, vstart, vend)
    vim.api.nvim_buf_set_name(out_buf, title)
    vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, output)
    vim.bo[out_buf].filetype = "git"
    vim.cmd("normal! gg")
end

-- Mappings (visual mode)
vim.keymap.set("v", "<leader>d", function() git_log_for_visual_selection("patch") end,
    { silent = true, desc = "Git log - patch (-L) for selection" })
vim.keymap.set("v", "<leader>D", function() git_log_for_visual_selection("summary") end,
    { silent = true, desc = "Git log - summary (-L -s) for selection" })
