local status_ok, indent = pcall(require, 'ibl')

if not status_ok then
  return
end

indent.setup()
