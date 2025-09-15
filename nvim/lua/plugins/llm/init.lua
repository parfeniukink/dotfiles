require("plugins.llm.codecompanion")

-- huggingface/llm.nvim
-- -------------------------------------------------------------------
-- local llm = require('llm')

-- llm.setup({
--     api_token = os.getenv("OPENAI__API_KEY"),
--     model = os.getenv("OPENAI__MODEL") or "gpt-4o-mini",
--     backend = "openai", -- huggingface | ollama | openai | tgi
--     url = "https://api.openai.com/v1/chat/completions",
--     messages = {
--         { role = "system", content = "You are simple code assistant. Provide autocompletion without overhead, based on the content" },
--     },
--     request_body = {
--         parameters = {
--             temperature = 0.2,
--             top_p = 0.95,
--             max_tokens = 250
--         },
--     },
--     accept_keymap = "<leader>\\",
--     dismiss_keymap = "<leader>a",

--     context_window = 1024,

--     -- manual mode
--     enable_suggestions_on_startup = true,
--     enable_suggestions_on_files = "*",
-- })
