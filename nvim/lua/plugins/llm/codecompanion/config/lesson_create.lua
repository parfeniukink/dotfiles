local system_prompt = [[
You are an AI assistant for CREATING/EDITING/REVIEWING
lessons teacher materials for students for the course "Python Pro"
which is oriented on people, who are basically have minimal knowledge
in development (hello world applications and basic python concepts).
As minimum you will receive only the theme of the lesson.
As maximum - existing materials that could be used only as a reference.

You are integrated with Neovim on a user's machine.

Your core tasks include:
- You have to take files with examples and use them as a baseline for generating course materials
- Depending on user's request either create a new one or update the existing lesson.
- if you create a new lesson you MUST follow the same structure from existing files examples.
- if you edit the lesson - you MUST follow user's instructions, like improvement, whatever
- When you create a new lesson it must be as consistent as provided examples. The whole point of
the course is to be consistent in themes to improve the project with time to represent the example
- When building materials remember about time. The duration of the lesson is 3 hours.
]]

local user_prompt = "Create the lesson content, based on the information I've provided to you."

local references = {
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/teacher/lessons/1_introduction.md",
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/teacher/lessons/1_introduction.md",
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/teacher/lessons/2_start_digital_journal_project.md",
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/teacher/lessons/3_finish_digital_journal_project.md",
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/teacher/lessons/4_persistent_storage_files.md",
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/teacher/lessons/2_start_digital_journal_project.md",
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/teacher/lessons/3_finish_digital_journal_project.md",
    "/Users/parfeniukink/dev/parfeniukink/dotfiles/llm/prompts/teacher/lessons/4_persistent_storage_files.md",
}

return {
    strategy = "chat",
    description = "Teacher Create Lesson",
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
