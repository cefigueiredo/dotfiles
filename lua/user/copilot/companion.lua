local copilot_adapter = function()
  return require("codecompanion.adapters.http").extend("copilot", {
    schema = {
      model = {
        default = "claude-sonnet-4"
      }
    },
  })
end

local markdown_ok, markdown = pcall(require, "render-markdown")
if markdown_ok then
  markdown.setup({
    file_type = { "markdown", "codecompanion" }
  })
end

return {
  setup = function()
    local companion_ok, companion = pcall(require, "codecompanion")

    if not companion_ok then
      return
    end

    companion.setup({
      adapters = {
        http = { copilot = copilot_adapter }
      },
      opts = {
        log_level = "DEBUG",
      },
      display = {
        action_palette = {
          provider = "telescope"
        }
      }
    })
  end
}
