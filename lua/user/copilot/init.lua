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

require("user.copilot.chat").setup()
require("user.copilot.companion").setup()
