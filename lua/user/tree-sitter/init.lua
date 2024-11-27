local treesitter_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
  vim.notify("nvim-treesitter not found", vim.log.levels.WARN)
  return
end

treesitter_config.setup {
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
  highlight = {
    enable = true,
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

require 'treesitter-context'

local function enable_foldexpr(bufnr)
  vim.api.nvim_buf_call(bufnr, function()
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.cmd.normal('zx')
  end)
end

local folding_group = vim.api.nvim_create_augroup('treesitter_fold', { clear = false })

vim.api.nvim_create_autocmd('FileType', {
  group = folding_group,
  callback = function(args)
    if not pcall(vim.treesitter.language.get_lang, args.match) then
      return
    end

    if vim.api.nvim_buf_line_count(args.buf) > 20000 then
      vim.notify('file too large, ignoring folding', vim.log.levels.INFO)
      return
    end

    enable_foldexpr(args.buf)
  end,
})
