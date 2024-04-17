local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
  return
end

local on_attach = require("user.nvim-tree.on-attach")

nvim_tree.setup({
  on_attach = on_attach,
  filters = {
    dotfiles = true,
    custom = {"^\\.git"}
  },
  filesystem_watchers ={
    ignore_dirs = {
      "node_modules"
    }
  },
  renderer= {
    group_empty = true,
    highlight_opened_files = "all",
    icons = {
      glyphs = {
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        }
      }
    }
  }
})
