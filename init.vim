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
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'mileszs/ack.vim'
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
call plug#end()

" nvim-cmp settings
set completeopt=menu,menuone,noselect

" General settings
syntax on
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
set foldmethod=indent " Test syntax after `syntax on` setting
set list " list and listchar - show special characters like: \n
set listchars=eol:¶
set mouse=a
set nobackup
set noshowmode
set noswapfile
set number
set ruler
set shiftwidth=2
set splitbelow
set splitright
set tabstop=2
set termguicolors
set laststatus=1 " 1 = show status bar if >= 2 windows; 2 = always
set wildignore+=*/tmp/* " ignore conditions for for ctr-p/fzf
set wildignore+=*.jpg,*.gif,*.gem,*.o,*.so,*.swp,*.zip,*.log

lua require 'user.lsp_config'
lua require 'user.cmp'
lua require 'user.nvim-tree'

""General Mappings

autocmd FileType ruby,eruby,python,elixir,exs,javascript,java,jst,go,html,haml,coffee autocmd BufWritePre <buffer> :%s/\s\+$//e

"  Open 10lines console at bottom
command Bterm bo 10sp +term

"  Yank file_path to system buffer
nmap <F4> :let @+ = expand("%")<CR>

"  fzf
let g:fzf_command_prefix="Fzf"
nmap <C-f> :FZF<CR>
nmap <C-p> :FZF<CR>

"  nvim-tree.lua
nnoremap <F2> :NvimTreeToggle<CR>
nnoremap <F3> :NvimTreeFindFile<CR>

"  <Esc> to exit terminal insert mode
tnoremap <Esc> <C-\><C-n>

" Ack
let g:ackprg='ag --vimgrep --ignore-case --ignore "\.git$\|\.hg$\|\.svn$"'
let g:ack_mappings = {
      \   "h": "<C-W><CR>:exe 'wincmd ' (&splitbelow ? 'J' : 'K')<CR><C-W>p<C-W>J<C-W>p",
      \   "H": "<C-W><CR>:exe 'wincmd ' (&splitbelow ? 'J' : 'K')<CR><C-W>p<C-W>J",
      \   "v": "<C-W><CR>:exe 'wincmd ' (&splitright ? 'L' : 'H')<CR><C-W>p<C-W>J<C-W>p",
      \   "gv": "<C-W><CR>:exe 'wincmd ' (&splitright ? 'L' : 'H')<CR><C-W>p<C-W>J"
      \ }
