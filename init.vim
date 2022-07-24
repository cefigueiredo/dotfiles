call plug#begin()
  Plug 'dracula/vim', { 'as': 'dracula' }
  "Plug 'preservim/nerdtree'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim'
  Plug 'ap/vim-css-color'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-rails'
  Plug 'neovim/nvim-lspconfig'
  Plug 'sirver/ultisnips' 
  Plug 'honza/vim-snippets'
  Plug 'Trevoke/ultisnips-rspec'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'
  Plug 'rafamadriz/friendly-snippets'
call plug#end()

" nvim-cmp settings
set completeopt=menu,menuone,noselect

" General settings
syntax on
colorscheme dracula

set autoindent
set background=dark
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

lua require 'lua.user.lsp_config'
lua require 'lua.user.cmp'

""General Mappings

"  Open 10lines console at bottom
command Bterm bo 10sp +term

"  Yank file_path to system buffer
nmap <F4> :let @+ = expand("%")<CR>

"  fzf
let g:fzf_command_prefix="Fzf"
nmap <C-f> :FZF<CR>
nmap <C-p> :FZF<CR>

"  NerdTree
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>

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
