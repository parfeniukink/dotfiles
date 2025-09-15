local config = require("plugins.llm.codecompanion.config")

-- 🔗 Links
-- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua

require("codecompanion").setup({
    prompt_library = {
        ["Documentation Generation"] = config.documentation_generation,
        ["Commit Message"] = config.commit_message,
        ["Unit Test"] = config.unit_test,
        ["Teacher Homework Reviewer"] = config.hw_review,
        ["Teacher Create Lesson"] = config.lesson_create,
        ["Lead Autopilot Assistant"] = config.leadautopilot_assistant,
    },
    opts = {
        system_prompt = function(_)
            return config.core
        end,
    },
    adapters = {
        openai = function()
            return require("codecompanion.adapters").extend("openai", {
                env = {
                    url = "https://api.openai.com/v1/",
                    api_key = os.getenv("OPENAI_API_KEY"),
                    chat_url = "/chat/completions",
                    models_endpoint = "/models",
                },
                schema = {
                    model = {
                        default = os.getenv("OPENAI_MODEL"),
                    },
                },
            })
        end,
        openai_mini = function()
            return require("codecompanion.adapters").extend("openai", {
                env = {
                    url = "https://api.openai.com/v1/",
                    api_key = os.getenv("OPENAI_API_KEY"),
                    chat_url = "/chat/completions",
                    models_endpoint = "/models",
                },
                schema = {
                    model = {
                        default = "gpt-4.1-mini"
                    },
                },
            })
        end,
        openai_turbo = function()
            return require("codecompanion.adapters").extend("openai", {
                env = {
                    url = "https://api.openai.com/v1/",
                    api_key = os.getenv("OPENAI_API_KEY"),
                    chat_url = "/chat/completions",
                    models_endpoint = "/models",
                },
                schema = {
                    model = {
                        default = "gpt‑3.5‑turbo‑0125"
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
            name = "default",
            adapter = "openai",
            model = "gpt-4.1",
            keymaps = {
                -- yolo_mode = {
                --     modes = { n = "gqy" },
                --     index = 18,
                --     callback = "keymaps.yolo_mode",
                --     description = "YOLO mode toggle",
                -- },
            }
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
