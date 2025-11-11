local claudecode_ok, claude = pcall(require, "claudecode")
if not claudecode_ok then
  return
end

-- Check if the claude cli is installed
local has_claude = vim.fn.executable("claude")
if has_claude == 0 then
  return
end

claude.setup({
  terminal = {
    split_width_percentage = 0.35,
  }
})

local keymaps = {
  { "<leader>c",  "<cmd>ClaudeCode<cr>",            desc = "ClaudeCode: Toggle Claude" },
  { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "ClaudeCode: Focus Claude" },
  { "<leader>cr", "<cmd>ClaudeCode --resume<cr>",   desc = "ClaudeCode: Resume Claude" },
  { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "ClaudeCode: Continue Claude" },
  { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "ClaudeCode: Select Claude model" },
  { "<leader>as", "<cmd>ClaudeCodeAdd %<cr>",       desc = "ClaudeCode: Add current buffer" },
  { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        desc = "ClaudeCode: Send visual selection to Claude",     mode = "v" },
  { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "ClaudeCode: Accept diff" },
  { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "ClaudeCode: Deny diff" },
  -- { "<leader>lta", "<cmd>ClaudeCodeTreeAdd<cr>",     desc = "ClaudeCode: Add file", ft = { "NvimTree" } },
}

for _, keymap in ipairs(keymaps) do
  local mode = keymap.mode or "n"
  local desc = keymap.desc or ""

  vim.api.nvim_set_keymap(
    mode,
    keymap[1],
    keymap[2],
    { desc = desc, silent = true, noremap = true }
  )
end
