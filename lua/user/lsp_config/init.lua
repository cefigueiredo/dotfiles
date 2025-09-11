local start_ok, nvim_lsp = pcall(require, 'lspconfig')

if not start_ok then
  return
end

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
    scope = "line"
  },
}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- lsp mappings
  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'gdc', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gdf', '<cmd>lua vim.lsp.buf.definition({ reuse_win = true })<CR>', opts)
  buf_set_keymap('n', 'gdv', '<cmd>lua require"telescope.builtin".lsp_definitions({ jump_type="vsplit" })<CR>', opts)
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({bufnr}))
  end
end

-- adds ShowRubyDeps command to show dependencies in the quickfix list.
-- add the `all` argument to show indirect dependencies as well
local function add_ruby_deps_command(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps",
                                          function(opts)

        local params = vim.lsp.util.make_text_document_params()

        local showAll = opts.args == "all"

        client.request("rubyLsp/workspace/dependencies", params,
                        function(error, result)
            if error then
                print("Error showing deps: " .. error)
                return
            end

            local qf_list = {}
            for _, item in ipairs(result) do
                if showAll or item.dependency then
                    table.insert(qf_list, {
                        text = string.format("%s (%s) - %s",
                                              item.name,
                                              item.version,
                                              item.dependency),

                        filename = item.path
                    })
                end
            end

            vim.fn.setqflist(qf_list)
            vim.cmd('copen')
        end, bufnr)
    end, {nargs = "?", complete = function()
        return {"all"}
    end})
end

-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = vim.lsp.protocol.make_client_capabilities()
local flags = { debounce_text_changes = 150, }

nvim_lsp['lua_ls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

nvim_lsp['ruby_lsp'].setup {
  capabilities = capabilities,
  --init_options = {
  --  formatter = 'standard',
  --  linters = { 'standard' },
  --  addonSettings = {
  --    ["Ruby LSP Rails"] = {
  --      enablePendingMigrationsPrompt = true
  --    },
  --  },
  --},

  on_attach = function(client, bufnr)
    pcall(on_attach, client, bufnr)

    pcall(add_ruby_deps_command, client, bufnr)

    if require("vim.lsp.diagnostic")._enable then
      return
    end

    local callback = function()
      local params = vim.lsp.util.make_text_document_params(bufnr)

      client.request(
        'textDocument/diagnostic',
        { textDocument = params },
        function(err, result)
          if err then vim.lsp.log.error("ruby-lsp - diagnostics error - %s", vim.inspect(err)) end
          if not result then return end

          vim.lsp.diagnostic.on_publish_diagnostics(
            nil,
            vim.tbl_extend('keep', params, { diagnostics = result.items }),
            { client_id = client.id }
          )
        end
      )
    end

    callback()

    local group = vim.api.nvim_create_augroup('ruby_ls', { clear = false })
    vim.api.nvim_create_autocmd(
      { 'BufEnter', 'BufWritePre', 'BufReadPost', 'InsertLeave', 'TextChanged' },
      {
        buffer = bufnr,
        callback = callback,
        group = group,
      }
    )
  end
}

---nvim_lsp['solargraph'].setup {
---  on_attach = attach_mappings,
---  flags = flags,
---  capabilities = capabilities,
---}

nvim_lsp['elixirls'].setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
  cmd = { "/home/cefig/dev/elixir-ls-1.13/language_server.sh" },
}

nvim_lsp['rust_analyzer'].setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
  cmd = { "rustup", "run", "stable", "rust-analyzer" },
}

nvim_lsp['pylsp'].setup {}
