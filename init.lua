vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- General settings

vim.o.autoindent = true
vim.o.guicursor = 'n-v-c-sm:blinkon200-blinkwait100,i-ci-ve:ver25-blinkon200-blinkwait100,r-cr-o:hor20-blinkon200-blinkwait100'
vim.opt.colorcolumn = '80'
vim.o.clipboard = 'unnamedplus'
vim.o.encoding = 'utf-8'
vim.o.expandtab = true
vim.o.foldlevelstart = 99
vim.o.list = true
vim.o.listchars = 'eol:¶'
vim.o.mouse = 'a'
vim.o.backup = false
vim.o.showmode = false
vim.o.swapfile = false
vim.o.number = true
vim.o.cursorline = true
vim.o.ruler = true
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.laststatus = 2 -- 1 = show status bar if >= 2 windows; 2 = always
vim.o.wrap = false
vim.o.updatetime = 100
vim.o.scrolloff = 3
vim.o.winborder = 'rounded'
vim.opt.wildignore:append { '*/tmp/*' } -- ignore conditions for for ctr-p/fzf
vim.opt.wildignore:append {
  '*.jpg', '*.gif', '*.gem', '*.o', '*.so', '*.swp', '*.zip', '*.log'
}

vim.keymap.set('n', '<F2>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<F3>', '<cmd>NvimTreeFindFile<CR>', { desc = 'Toggle file explorer and find current file' })
vim.keymap.set('n', '<F4>', '<cmd>let @+ = expand("%")<CR>', { desc = 'Copy current file path to clipboard' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

local function gh(repo) return 'https://github.com/' .. repo end

require 'user.colorscheme'

vim.pack.add({
  { src = gh 'airblade/vim-gitgutter' },
  { src = gh 'tpope/vim-fugitive' },
  { src = gh 'tpope/vim-rhubarb' },
  { src = gh 'ap/vim-css-color' },
  { src = gh 'elixir-lang/vim-elixir' },
  { src = gh 'honza/vim-snippets' },
  { src = gh 'nvim-tree/nvim-tree.lua' },
  { src = gh 'nvim-tree/nvim-web-devicons' },
  { src = gh 'neovim/nvim-lspconfig' },
  { src = gh 'rafamadriz/friendly-snippets' },
  { src = gh 'sirver/ultisnips' },
  { src = gh 'tpope/vim-surround' },
  { src = gh 'trevoke/ultisnips-rspec' },
  { src = gh 'nvim-lua/plenary.nvim' },
  { src = gh 'nvim-telescope/telescope.nvim' },
  { src = gh 'nvim-telescope/telescope-live-grep-args.nvim' },
  { src = gh 'nvim-telescope/telescope-ui-select.nvim' },
  -- m-treesitter branches: master for neovim 11.x - main for neovim 12.x
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  --
  { src = gh 'godlygeek/tabular' },
  { src = gh 'lukas-reineke/indent-blankline.nvim' },
  --
  { src = gh 'stevearc/oil.nvim' },
  { src = gh 'nvim-lualine/lualine.nvim' },
  { src = gh 'mfussenegger/nvim-lint'  },
  -- AI-Related
  { src = gh 'zbirenbaum/copilot.lua' },
  { src = gh 'CopilotC-Nvim/CopilotChat.nvim' },
  { src = gh 'olimorris/codecompanion.nvim', version = 'v17.33.0' },
  { src = gh 'franco-ruggeri/codecompanion-lualine.nvim' },
  -- { src = gh 'Davidyz/VectorCode' },
  { src = gh 'folke/snacks.nvim' },
  { src = gh 'coder/claudecode.nvim' },
  --
  -- cmp
  { src = gh 'hrsh7th/nvim-cmp' },
  { src = gh 'hrsh7th/cmp-buffer' },
  { src = gh 'hrsh7th/cmp-cmdline' },
  { src = gh 'hrsh7th/cmp-nvim-lsp' },
  { src = gh 'hrsh7th/cmp-path' },
  { src = gh 'quangnguyen30192/cmp-nvim-ultisnips' },
  { src = gh 'zbirenbaum/copilot-cmp' },
})

require 'user.oil'
require 'user.telescope'
require 'user.tree-sitter'
require 'user.lsp_config'
require 'user.nvim-tree'
require 'user.indent-blankline'
require 'user.copilot'
require 'user.claudecode'
require 'user.lualine'
require 'user.cmp'
require 'user.linters'

-- :help lua-guide-autocmd
