call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'ap/vim-css-color'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'elixir-lang/vim-elixir'
  Plug 'honza/vim-snippets'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'neovim/nvim-lspconfig'
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'sirver/ultisnips'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-surround'
  Plug 'trevoke/ultisnips-rspec'
  Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-rhubarb'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-refactor'
  Plug 'nvim-treesitter/playground'
call plug#end()

lua require 'user.cmp'
lua require 'user.tree-sitter'
lua require 'user.lsp_config'
lua require 'user.nvim-tree'

" nvim-cmp settings
set completeopt=menu,menuone,noselect

" General settings
" syntax on
colorscheme dracula

set autoindent
"set background=dark
set guicursor=n-v-c-sm:blinkon200-blinkwait100,i-ci-ve:ver25-blinkon200-blinkwait100,r-cr-o:hor20-blinkon200-blinkwait100
set backspace=2
set colorcolumn=80
set clipboard=unnamedplus
set encoding=utf-8
set expandtab
set foldlevelstart=99
set foldmethod=expr " Test syntax after `syntax on` setting
set foldexpr=nvim_treesitter#foldexpr()
set list " list and listchar - show special characters like: \n
set listchars=eol:¶
set mouse=a
set nobackup
set noshowmode
set noswapfile
set number
set relativenumber
set cursorline
set ruler
set shiftwidth=2
set splitbelow
set splitright
set tabstop=2
set termguicolors
set laststatus=1 " 1 = show status bar if >= 2 windows; 2 = always
set wildignore+=*/tmp/* " ignore conditions for for ctr-p/fzf
set wildignore+=*.jpg,*.gif,*.gem,*.o,*.so,*.swp,*.zip,*.log
set nowrap
set updatetime=100

" background transparent
hi Normal guibg=None

""General Mappings

autocmd FileType ruby,eruby,python,elixir,exs,javascript,java,jst,go,html,haml,coffee autocmd BufWritePre <buffer> :%s/\s\+$//e

"  Open 10lines console at bottom
augroup BTERM
  command! Bterm bo 10sp +term
augroup END

"  Yank file_path to system buffer
nmap <F4> :let @+ = expand("%")<CR>

"  Move lines up
nmap K :m .-2<CR>==
vmap K :m '<-2<CR>gv=gv

"  Move lines down
nmap J :m .+1<CR>==
vmap J :m '>+1<CR>gv=gv

nmap <C-p> :Telescope find_files<CR>
nmap <C-f> :Telescope live_grep<CR>

"  nvim-tree.lua
nnoremap <F2> :NvimTreeToggle<CR>
nnoremap <F3> :NvimTreeFindFile<CR>

"  <Esc> to exit terminal insert mode
tnoremap <Esc> <C-\><C-n>

" vim-airline
"let g:airline#extensions#branch#format = 'WrapbookCustomBranchName'
"function! WrapbookCustomBranchName(name)
"  let shortcut_ticket = matchstr(name, '\c\w\+//')
"
"  check :h /\zs /\ze /\c
"
"endfunction
