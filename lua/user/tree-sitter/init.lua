local treesitter_ok, nvim_treesitter = pcall(require, "nvim-treesitter")
if not treesitter_ok then
  vim.notify("nvim-treesitter not found", vim.log.levels.WARN)
  return
end

local ensured_installed = {
  "c",
  "elixir",
  "embedded_template",
  "html",
  "javascript",
  "scss",
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
}

nvim_treesitter.install(ensured_installed)

local function enable_foldexpr(bufnr)
  vim.api.nvim_buf_call(bufnr, function()
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.cmd.normal('zx')
  end)
end

local treesitter_group = vim.api.nvim_create_augroup('treesitter', { clear = false })

vim.api.nvim_create_autocmd('FileType', {
  pattern = ensured_installed,
  group = treesitter_group,
  callback = function(args)
    vim.treesitter.start()

    if vim.api.nvim_buf_line_count(args.buf) > 20000 then
      vim.notify('file too large, ignoring folding', vim.log.levels.INFO)
      return
    end

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    enable_foldexpr(args.buf)
  end,
})
