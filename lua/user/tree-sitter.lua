require'nvim-treesitter.configs'.setup{
  ensure_installed = {
    "c",
    "lua",
    "ruby",
    "javascript",
    "help",
    "query",
    "vim",
    "elixir",
  },

  indent = { enable = false },
  highlight={
    enable=true,
    additional_vim_regex_highlighting = false,
  },
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "<leader>sr",
      }
    }
  }
}
