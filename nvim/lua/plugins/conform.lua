local conform = require("conform")

-- search [tool.ruff] in pyproject for ruff configuration
local function find_pyproject_toml(start_path)
    local path = vim.fs.dirname(start_path)
    while path do
        local candidate = path .. "/pyproject.toml"
        local f = io.open(candidate, "r")
        if f then
            f:close()
            return candidate
        end
        local parent = vim.fs.dirname(path)
        if parent == path then return nil end
        path = parent
    end
    return nil
end

-- true if there is
local function ruff_in_pyproject_toml(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local pyproject = find_pyproject_toml(bufname)
    if not pyproject then return false end
    for line in io.lines(pyproject) do
        if line:match("^%[tool%.ruff") then
            return true
        end
    end
    return false
end

-- returns true if some executable is available
local function has_executable(executable)
    return vim.fn.executable(executable) == 1
end

local function venv_bin(cmd)
    local buf_dir = vim.fn.expand("%:p:h")
    local root = vim.fs.find({ ".venv", "venv" }, { upward = true, path = buf_dir })[1]
    if root then
        local bin = root .. "/bin/" .. cmd
        if vim.fn.executable(bin) == 1 then
            return bin
        end
    end
    return cmd
end


local function local_prettier()
    local buf_dir = vim.fn.expand("%:p:h")
    local root = vim.fs.find({ "node_modules" }, { upward = true, path = buf_dir })[1]
    if root then
        local bin = vim.fs.dirname(root) .. "/node_modules/.bin/prettier"
        if vim.fn.executable(bin) == 1 then
            return bin
        end
    end
    return "prettier"
end

conform.setup({
    formatters_by_ft = {
        go = { "gofmt" },
        python = function(bufnr)
            if has_executable("ruff") and ruff_in_pyproject_toml(bufnr) then
                return { "ruff_format" }
            else
                return { "isort", "black" }
            end
        end,
        dart = { "dart_format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        sql = { "sqlfmt" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
    },
    formatters = {
        black = { command = venv_bin("black") },
        isort = { command = venv_bin("isort") },
        ruff_format = { command = venv_bin("ruff") },
        prettier = {
            command = local_prettier(),
            prepend_args = { "--tab-width", "2" },
        },
    },
    format_on_save = nil,
    --     async = false,
    --     timeout_ms = 100,
    --     lsp_fallback = true
    -- },
    notify_on_error = true,

})

vim.keymap.set("n", "<C-L>", function()
    conform.format({
        async = true,
        timeout_ms = 200,
        lsp_fallback = true,
    })
end, {})
