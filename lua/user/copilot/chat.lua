local chat_ok, chat = pcall(require, "CopilotChat")

local add_keymaps = function()
  local actions = require("CopilotChat.actions")
  local telescope = require("CopilotChat.integrations.telescope")

  local prompt_actions = function()
    telescope.pick(actions.prompt_actions())
  end

  local ask = function()
    local input = vim.fn.input("Ask CopilotChat: ")
    if input ~= "" then
      chat.ask(input)
    end
  end

  vim.keymap.set({ "n" }, "<leader>cc", chat.toggle, { noremap = true, silent = true, desc = "CopilotChat - Toggle" })
  vim.keymap.set({ "v" }, "<leader>cc", chat.open, { noremap = true, silent = true, desc = "CopilotChat - Toggle" })
  vim.keymap.set({ "n", "v" }, "<leader>ccp", prompt_actions,
    { noremap = true, silent = true, desc = "CopilotChat - Pick actions" })
  vim.keymap.set({ "n", "v" }, "<leader>cca", ask,
    { noremap = true, silent = true, desc = "CopilotChat - Pick actions" })
end

return {
  setup = function()
    if not chat_ok then
      return
    end

    chat.setup({
      model = 'claude-3.5-sonnet'
    })

    add_keymaps()
  end
}
