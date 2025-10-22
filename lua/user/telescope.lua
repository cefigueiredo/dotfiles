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
  defaults = {
    mappings = {
      n = {
        ["<C-k>"] = "preview_scrolling_up",
        ["<C-j>"] = "preview_scrolling_down",
        ["<C-h>"] = "preview_scrolling_left",
        ["<C-l>"] = "preview_scrolling_right",
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      file_ignore_patterns = { "node_modules", ".git" },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
      -- even more opts
      -- width = 0.5,
      -- height = 0.5,
      -- previewer = false,
      -- border = true,
      -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      }
    },
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
vim.keymap.set('n', '<leader>b', telescope_builtin.buffers, { noremap = true })
vim.keymap.set('n', '<C-f>', telescope.extensions.live_grep_args.live_grep_args, { noremap = true })

telescope.load_extension("ui-select")
telescope.load_extension("live_grep_args")
