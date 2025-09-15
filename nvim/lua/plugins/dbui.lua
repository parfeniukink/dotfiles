vim.g.db_ui_icons = {
    expanded = "▾",
    collapsed = "▸",
    saved_query = "*",
    new_query = "+",
    tables = "~",
    buffers = "»",
    connection_ok = "✓",
    connection_error = "✕",
}

vim.g.db_ui_disable_progress_bar = 1

map('n', '<leader>s', '<Plug>(DBUI_SaveQuery)', { silent = true, noremap = true })

