local ok, plugins = pcall(require, "plugins.setup")

if ok then
    require("plugins.treesitter")
    require("plugins.telescope")
    require("plugins.harpoon")
    require("plugins.tagbar")
    require("plugins.tree")
    require("plugins.todos")
    require("plugins.commentary")
    require("plugins.tabby")
    require("plugins.git")
    require("plugins.lsp")
    require("plugins.dbui")
    require("plugins.llm")
    require("plugins.colors")
    require("plugins.conform")
    print("🚀 Happy development")
end
