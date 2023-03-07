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

  indent = { enable = true },
  highlight={
    enable=true,
    additional_vim_regex_highlighting = false,
  },
}
