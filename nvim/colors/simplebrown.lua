vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "simplebrown"

local palette = {
    -- bg = "#41311c",
    bg = "#2b2113",
    fg = "#e2d8ad",
    -- dev syntax palette
    comment = "#a5a486",
    string = "#808638",  -- soft green
    keyword = "#e1943e", -- peach
    func = "#d46101",    -- orange
    method = "#d46101",  -- orange
    type = "#d46101",    -- light brown
    -- method = "#e67f48",    -- orange
    -- type = "#e67f48",

    const = "#ffa07a", -- light salmon
    cursor = "#e6d7a7",
    line = "#4b3928",
    -- git diff
    diffadd = "#48643b",
    diffchg = "#735f3a",
    diffgone = "#3e2f1c",
    diffdel = "#704b32",
    gitadd = "#627454",
    gitchg = "#b6a265",
    gitdel = "#a85a32",
    -- simple colors
    orange = "#e07f00",
    red = "#d76453",
    sky = "#95bdff",
    visual = "#735731",
}



local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- Editor
hi("Normal", { fg = palette.fg, bg = palette.bg })
hi("Comment", { fg = palette.comment, italic = true })
hi("Error", { fg = palette.red, italic = true })
hi("CursorLine", { bg = palette.line })
hi("Cursor", { bg = palette.cursor })
hi("LineNr", { fg = palette.line })
hi("Visual", { bg = palette.type })
hi("StatusLine", { fg = palette.bg, bg = palette.fg })
hi("Visual", { bg = palette.visual })
hi("StatusLine", { bg = palette.bg })
hi("StatusLineNC", { link = "StatusLine" })
hi("StatusLineTermNC", { link = "StatusLine" })


-- Syntax
hi("String", { fg = palette.string })
hi("Constant", { fg = palette.const, bold = true })
hi("Function", { fg = palette.func })
hi("Keyword", { fg = palette.keyword, bold = false })
hi("Special", { fg = palette.keyword, bold = false })
hi("Type", { fg = palette.type, bold = false })
hi("Identifier", { fg = "#ebbd58", bold = true }) -- gold
hi("Statement", { fg = palette.keyword })
hi("PreProc", { fg = palette.type })
hi("Number", { fg = palette.const })
hi("Boolean", { fg = palette.const })

-- Treesitter (major groups)
hi("@comment", { link = "Comment" })
hi("@string", { link = "String" })
hi("@function", { link = "Function" })
hi("@keyword", { link = "Keyword" })
hi("@type", { link = "Keyword" })

-- GitSigns
hi("GitSignsAdd", { fg = palette.gitadd })
hi("GitSignsChange", { fg = palette.gitchg })
hi("GitSignsDelete", { fg = palette.gitdel })

-- Diff
hi("DiffAdd", { bg = palette.diffadd })
hi("DiffChange", { bg = palette.diffchg })
hi("DiffDelete", { bg = palette.diffdel })
hi("DiffText", { bg = palette.gitchg })

hi("diffLine", { link = "Normal" })
hi("diffSubName", { link = "Normal" })
hi("diffAdded", { link = "String" })
hi("diffRemoved", { link = "Error" })
hi("diffFile", { link = "Comment" })
hi("gitDiff", { link = "Comment" })



-- TODO
hi("TodoBgTODO", { fg = palette.sky })
hi("TodoFgTODO", { fg = palette.sky })
hi("TodoBgNOTE", { fg = palette.sky })
hi("TodoFgNOTE", { fg = palette.sky })
hi("TodoBgWARNING", { fg = palette.orange })
hi("TodoFgWARNING", { fg = palette.orange })
hi("TodoBgWARN", { fg = palette.orange })
hi("TodoFgWARN", { fg = palette.orange })
hi("TodoBgFIX", { fg = palette.red })
hi("TodoFgFIX", { fg = palette.red })

-- TagBar
hi("TagbarType", { link = "Keyword" })

-- Folds
hi("Folded", { fg = palette.comment, bg = "NONE" })
hi("FoldColumn", { fg = palette.fg, bg = palette.bg })


-- Diagnostics
hi("DiagnosticHint", { fg = palette.red, bg = "NONE" })


-- Python
hi("@module.python", { link = "Normal" })
hi("@variable.python", { link = "Normal" })
hi("@variable.member.python", { link = "Normal" })
hi("@attribute.python", { link = "Normal" })
hi("@attribute.builtin.python", { link = "Normal" })
hi("@keyword.import.python", { link = "Identifier" })
hi("@keyword.operator.python", { link = "Type" })
hi("@keyword.conditional.python", { link = "Keyword" })
hi("@keyword.coroutine.python", { link = "Type" })
hi("@keyword.exception.python", { fg = palette.red, bold = true })
hi("@type.builtin.python", { link = "Normal" })
hi("@function.builtin.python", { link = "Normal" })
hi("@function.call.python", { link = "Normal" })
hi("@function.method.python", { fg = palette.method })
hi("@function.method.call.python", { link = "Normal" })
hi("@constant.builtin.python", { link = "Keyword" })


-- Svelte
hi("@variable.member.javascript", { link = "Normal" })
hi("@lsp.typemod.variable.readonly.svelte", { link = "Normal" })
hi("@lsp.type.property.svelte", { link = "Normal" })


-- Lua
hi("@lsp.type.property.lua", { link = "Normal" })


-- TOML
hi("@property.toml", { link = "Keyword" })

hi("NormalFloat", { bg = "NONE" })
