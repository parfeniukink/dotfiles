-- require("catppuccin").setup({
--     flavour = "mocha",
--     transparent_background = false,
--     integrations = {
--         gitsigns = true,
--         nvimtree = true,
--         treesitter = true,
--     },
--     color_overrides = {
--         mocha = {
--             base = "#3E2F1C", -- dark brown base (instead of original)
--             mantle = "#4B3928",
--             crust = "#5A4535",
--             text = "#D6C7A1", -- soft beige text
--             surface0 = "#5B482D",
--             surface1 = "#7D6642",
--             surface2 = "#A8895C",
--         }
--     }
-- })

-- require("gruvbox").setup({
--     terminal_colors = true,
--     undercurl = false,
--     underline = false,
--     bold = false,
--     italic = {
--         strings = false,
--         emphasis = false,
--         comments = false,
--         operators = false,
--         folds = false,
--     },
--     strikethrough = true,
--     invert_selection = false,
--     invert_signs = false,
--     invert_tabline = false,
--     invert_intend_guides = false,
--     inverse = true,    -- invert background for search, diffs, statuslines and errors
--     contrast = "soft", -- can be "hard", "soft" or empty string
--     palette_overrides = {},
--     overrides = {},
--     dim_inactive = false,
--     transparent_mode = true,
-- })

-- simplebrown / gruvbox / catpuccin / default
vim.cmd([[
    set background=dark
    colorscheme simplebrown
]])

-- apply background transparency for themes which don't support those
-- vim.cmd([[
--     hi NormalFloat ctermbg=NONE guibg=NONE
--     hi NormalNC ctermbg=NONE guibg=NONE
--     hi Normal ctermbg=NONE guibg=NONE
-- ]])
