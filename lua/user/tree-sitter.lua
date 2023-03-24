require'nvim-treesitter.configs'.setup{
  ensure_installed = {
    "c",
    "elixir",
    "embedded_template",
    "help",
    "html",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "ruby",
    "rust",
    "sql",
    "vim",
    "yaml",
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
        smart_rename = "<leader>tr",
      }
    }
  },
  playground = {
    enable = true,
  },
  query_linter = {
    enable = true,
  },
}
