local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
  return
end

nvim_tree.setup({
  view = {
    mappings = {
      list = {
        { key = {"g?", "?"}, action = "toggle_help" }
      }
    }
  },
  filters = {
    dotfiles = true,
    custom = {"^\\.git"}
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
