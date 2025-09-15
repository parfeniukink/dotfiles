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
