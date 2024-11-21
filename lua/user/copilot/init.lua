local copilot_ok, copilot = pcall(require, "copilot")

if not copilot_ok then
  return
end

local setup_copilot = function(_)
  copilot.setup({
    suggestion = { enabled = false },
    panel = { enabled = false }
  })
end

local copilot_group = vim.api.nvim_create_augroup("MyCopilot", { clear = false })

vim.api.nvim_create_autocmd("VimEnter", {
  group = copilot_group,
  once = true,
  callback = setup_copilot
})

local chat_ok, chat = pcall(require, "CopilotChat")

if not chat_ok then
  return
end

chat.setup({
  model = 'claude-3.5-sonnet'
})
