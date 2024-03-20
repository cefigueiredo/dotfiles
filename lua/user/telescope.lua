local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  return
end

local lga_ok, lga_actions = pcall(require, "telescope-live-grep-args.actions")
if not lga_ok then
  return
end

local telescope_builtin = require("telescope.builtin")

-- local lga_actions = require("telescope-live-grep-args.actions")
telescope.setup {
  extensions = {
    live_grep_args = {
      auto_quotiong = true,
      mappings = {
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    }
  }
}

vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, { noremap = true })
vim.keymap.set('n', '<C-f>', telescope.extensions.live_grep_args.live_grep_args, { noremap = true })

telescope.load_extension("live_grep_args")
