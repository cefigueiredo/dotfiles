local cmp = require'cmp'
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

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
    ['<A-j>'] = cmp.mapping.scroll_docs(-4),
    ['<A-k>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(
      function(fallback) cmp_ultisnips_mappings.expand_or_jump_forwards(fallback) end,
      {"i", "s"}
    ),
    ['<S-Tab>'] = cmp.mapping(
      function(fallback) cmp_ultisnips_mappings.jump_backwards(fallback) end,
      {"i", "s"}
    )
  }),
  sources = cmp.config.sources({
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

