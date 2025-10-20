local tokyonight_ok, tokyonight = pcall(require, "tokyonight")
if not tokyonight_ok then
  return
end

tokyonight.setup({
  style = "night",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = {},
    variables = {},
    sidebars = "dark",
    floats = "dark",
  },
  day_brightness = 0.3,
  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = false,

  on_highlights = function(hl, colors)
    local background = vim.api.nvim_get_option_value("background", {scope = "global"})
    if background == "light" then
      hl.NormalNC = { bg = colors.bg_dark1, fg = colors.comment }

      hl.Normal = { bg = colors.bg, fg = colors.fg }
      return
    end

    hl.NormalNC = { bg = colors.bg, fg = colors.comment }

    hl.Normal = { bg = colors.bg_dark1, fg = colors.fg_dark }
  end,
})

vim.cmd "colorscheme tokyonight"

vim.api.nvim_set_hl(0, "FloatBorder", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu" })

-- set winhighlight=Normal:DraculaBgDarker,NormalNC:DraculaBgDark
