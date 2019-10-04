set nocompatible
filetype off


call plug#begin('~/.vim/plugged')

"Other Plugins
Plug 'scrooloose/nerdtree'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Trevoke/ultisnips-rspec'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'
Plug 'dsawardekar/ember.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-haml'
Plug 'kchmck/vim-coffee-script'
Plug 'mileszs/ack.vim'
Plug 'ap/vim-css-color'

call plug#end()
" Ultisnips Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories=["UltiSnips", "bundle/vim-snippets/UltiSnips", "bundle/ultisnips-rspec/UltiSnips"]

filetype plugin indent on    " required

set splitright
set splitbelow
set tabstop=2
set shiftwidth=2
set expandtab
set number
set updatetime=250
set nobackup
set noswapfile
set ruler
set number
set autoindent
set backspace=2
set list
set listchars=eol:¶
set encoding=utf-8
set laststatus=2
set noshowmode
set mouse=a

set foldmethod=syntax
set foldlevelstart=99

let g:indent_guides_start_level = 2
set shell=/bin/bash

colorscheme molokai

"ctrlp
set wildignore+=*/tmp/*
set wildignore+=*.jpg,*.gif,*.gem,*.o,*.so,*.swp,*.zip,*.log
let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_working_path_mode = 'r'
"let g:ctrlp_user_command = {
"      \   'types': {
"      \     1: ['.git', 'git ls-files --cached --others --exclude-standard %s'],
"      \   },
"      \   'fallback': 'ag --ignore-case --nogroup --nocolor --nobreak --ignore "\.git$\|\.hg$\|\.svn$" -g "" %s'
"      \ }
let g:ctrlp_user_command = 'ag --vimgrep --ignore-case --ignore "\.git$\|\.hg$\|\.svn$" -g "" %s'

"let g:ag_working_path_mode="ra"
"let g:ag_prog ='ag --vimgrep --ignore-case --nobreak'
"let g:ag_highlight=1

let g:ackprg='ag --vimgrep --ignore-case --ignore "\.git$\|\.hg$\|\.svn$"'
let g:ack_mappings = {
      \   "h": "<C-W><CR>:exe 'wincmd ' (&splitbelow ? 'J' : 'K')<CR><C-W>p<C-W>J<C-W>p",
      \   "H": "<C-W><CR>:exe 'wincmd ' (&splitbelow ? 'J' : 'K')<CR><C-W>p<C-W>J",
      \   "v": "<C-W><CR>:exe 'wincmd ' (&splitright ? 'L' : 'H')<CR><C-W>p<C-W>J<C-W>p",
      \   "gv": "<C-W><CR>:exe 'wincmd ' (&splitright ? 'L' : 'H')<CR><C-W>p<C-W>J"
      \ }
syntax on


map <F2> :NERDTreeToggle<CR>

"Yank file_path to system buffer
nmap <F4> :let @+ = expand("%")<CR>

tnoremap <Esc> <C-\><C-n>

autocmd FileType ruby,eruby,elixir,exs,javascript,jst,go,html,haml,coffee autocmd BufWritePre <buffer> :%s/\s\+$//e 

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
