local claudecode_ok, claude = pcall(require, "claudecode")

-- Check if the claude-cli file exists
local path = vim.fn.expand("~/.local/bin/claude-cli")
if vim.fn.filereadable(path) == 0 then
  return
end

if not claudecode_ok then
  return
end

claude.setup({
  terminal_cmd = "~/.local/bin/claude-cli",
})

local keymaps = {
  { "<leader>cc",  "<cmd>ClaudeCode<cr>",            desc = "ClaudeCode: Toggle Claude" },
  { "<leader>cct", "<cmd>ClaudeCode<cr>",            desc = "ClaudeCode: Toggle Claude" },
  { "<leader>ccf", "<cmd>ClaudeCodeFocus<cr>",       desc = "ClaudeCode: Focus Claude" },
  { "<leader>ccr", "<cmd>ClaudeCode --resume<cr>",   desc = "ClaudeCode: Resume Claude" },
  { "<leader>ccC", "<cmd>ClaudeCode --continue<cr>", desc = "ClaudeCode: Continue Claude" },
  { "<leader>ccm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "ClaudeCode: Select Claude model" },
  { "<leader>ccb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "ClaudeCode: Add current buffer" },
  { "<leader>ccs", "<cmd>ClaudeCodeSend<cr>",        desc = "ClaudeCode: Send to Claude",     mode = "v" },
  { "<leader>cda", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "ClaudeCode: Accept diff" },
  { "<leader>cdd", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "ClaudeCode: Deny diff" },
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
