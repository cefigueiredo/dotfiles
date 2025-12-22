local link_ok, lint = pcall(require, 'lint')

if not link_ok then
  return
end

-- local erb_lint = lint.linters.erb_lint
--
-- erb_lint.args = { 'exec', 'erb_lint', '--format', 'compact', '--autocorrect' }

require('lint').linters_by_ft = {
  javascript = {'eslint'},
  eruby = {'erb_lint'},
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  pattern = { "*.erb" },
  callback = function(opts)
    lint.try_lint('erb_lint')

    vim.api.nvim_buf_set_keymap(
      opts.buf,
      'n',
      '<leader>F',
      '<cmd>!bundle exec erb_lint --format compact --autocorrect ' .. opts.file .. ' > /dev/null<CR><cmd>e<CR>',
      { noremap = true, silent = true, desc = "Autocorrect ERB linting issues" }
    )
  end,
})
