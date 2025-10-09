local cmp = require'cmp'
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

local copilot_cmp_ok, copilot_cmp = pcall(require, "copilot_cmp")
if copilot_cmp_ok then
  copilot_cmp.setup({
    fix_pairs = true
  })
end

require("cmp_nvim_ultisnips").setup{}

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = function(fallback)
      if cmp.visible_docs() then
        cmp.mapping.scroll_docs(-4)
      else
        fallback()
      end
    end,
    ['<C-k>'] = function(fallback)
      if cmp.visible_docs() then
        cmp.mapping.scroll_docs(4)
      else
        fallback()
      end
    end,
    ['<C-Space>'] = function(fallback)
      if not cmp.visible() then
        return cmp.complete({})
      end
      if cmp.visible_docs() then
        return cmp.close_docs()
      end

      cmp.abort()
    end,
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(
      function(fallback) cmp_ultisnips_mappings.expand_or_jump_forwards(fallback) end,
      {"i", "s"}
    ),
    ['<S-Tab>'] = cmp.mapping(
      function(fallback)
        cmp.abort()
        fallback()
      end,
      {"i", "s"}
    )
  }),
  sources = cmp.config.sources({
    { name= "copilot" },
    { name = 'ultisnips' },
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer', keyword_length = 5 },
  })
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'buffer' },
  })
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'cmdline' },
  }, {
    { name = 'path' },
  }, {
    { name = 'buffer' },
  })
})

