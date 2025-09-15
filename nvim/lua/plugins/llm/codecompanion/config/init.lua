M = {}


M.core = require("plugins.llm.codecompanion.config.core")
M.documentation_generation = require("plugins.llm.codecompanion.config.documentation_generation")
M.commit_message = require("plugins.llm.codecompanion.config.commit_message")
M.unit_test = require("plugins.llm.codecompanion.config.unit_test")
M.hw_review = require("plugins.llm.codecompanion.config.hw_review")
M.lesson_create = require("plugins.llm.codecompanion.config.lesson_create")
M.leadautopilot_assistant = require("plugins.llm.codecompanion.config.leadautopilot_assistant")


return M
