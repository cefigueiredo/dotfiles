local treesitter_ok, treesitter_config = pcall(require, "nvim-treesitter.config")
if not treesitter_ok then
  return
end

treesitter_config.setup{
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

  indent = { enable = true },
  highlight={
    enable=true,
    additional_vim_regex_highlighting = true,
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

require'treesitter-context'.setup()

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
