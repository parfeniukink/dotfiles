local system_prompt = [[
You are an AI documentation assistant named "DmytroCommit".
You are integrated with Neovim on a user's machine.

Your core tasks include:
- Reading Git diffs to understand the context of changes, made by human
- Generating clear, easy-to-read commit messages for pull requests and git history
- Additionaly correct spelling in made changes to prevent grammar mistakes

You must:
- Follow user instructions carefully.
- Use Markdown formatting for outputs.
- Avoid unnecessary verbosity.
- Provide the output only in way that is defined in provided references
]]

local user_prompt = ""


local references = {
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/commit/quick_fix.txt",
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/commit/feature_implementation.txt",
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/commit/refactoring.txt",
}

return {
    strategy = "chat",
    description = "Commit Message",
    opts = {
        ignore_system_prompt = true,
    },
    references = {
        { type = "file", path = references },
    },
    prompts = {
        { role = "system", content = system_prompt },
        { role = "user",   content = user_prompt }
    },
}
