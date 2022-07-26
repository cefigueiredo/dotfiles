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
  renderer= {
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
