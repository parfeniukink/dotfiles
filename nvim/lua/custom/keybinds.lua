-- Setup basic mappings
-- ======================================================
function map(mode, shortcut, command, options)
    vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

function nmap(shortcut, command)
    map("n", shortcut, command, { noremap = true, silent = true })
end

function imap(shortcut, command)
    map("i", shortcut, command, { noremap = true })
end

function vmap(shortcut, command)
    map("v", shortcut, command, {})
end

-- Exit to the normal mode
imap("jk", "<Esc>")
imap("kj", "<Esc>")


-- Set the Leader key
vim.g.leader = "\\"


-- Panels and tabs
nmap("<S-T>", ":tabnew<CR>")
nmap("<S-S>", ":vsplit<CR>")
nmap("<S-W>", ":split<CR>")


-- Panels resize
vim.api.nvim_set_keymap('n', '<C-h>', ':horizontal resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':vertical resize +2<CR>', { noremap = true, silent = true })
