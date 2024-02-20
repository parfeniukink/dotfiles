-- relative numbers
vim.opt.rnu = true
-- numbers width
vim.opt.nuw = 2
vim.cmd("set signcolumn=yes")


-- when included, Vim will use the clipboard register "*"
-- for all yank, delete, change and put operations which
-- would normally go to the unnamed register
vim.opt.clipboard = "unnamed"

-- Disable highlight after search
vim.opt.hlsearch = false

-- time in milliseconds for redrawing the display
vim.opt.rdt = 2000

-- enable mouse in all modes
vim.opt.mouse = "a"

-- fail operation :q and :e for unsaved files
vim.opt.cf = true

-- time in milliseconds to wait for a mapped sequence to complete
vim.opt.tm = 500


-- folding configuration
vim.opt.foldmethod = "indent"
vim.opt.fdl = 99


-- turn off .swp and ~ files
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = false


-- tabs configuration
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")


-- bufflisted [testing]
vim.cmd("set buflisted")

vim.cmd("set guitablabel=%t")
