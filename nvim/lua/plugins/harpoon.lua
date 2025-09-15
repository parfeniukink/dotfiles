local harpoon = require("harpoon")

harpoon:setup({
    settings = {
        save_on_toggle = true
    }
})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>\\", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
