local ok_oil, oil = pcall(require, "oil")

if not ok_oil then
  return
end

oil.setup({
  default_file_explorer = false,
})
