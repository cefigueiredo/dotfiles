local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
  return
end

local codecompanion = {
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filetype' },
    lualine_c = {},
    lualine_x = { 'codecompanion' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'filetype' },
    lualine_c = {},
    lualine_x = { 'codecompanion' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  filetypes = { 'codecompanion' }
}

lualine.setup({
  extensions = { 'nvim-tree', 'oil', 'fugitive', 'quickfix', codecompanion }
})
