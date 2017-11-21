set nocompatible
filetype off


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"Other Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Trevoke/ultisnips-rspec'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'elixir-lang/vim-elixir'
Plugin 'tpope/vim-rails'
Plugin 'pangloss/vim-javascript'
Plugin 'dsawardekar/ember.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'kchmck/vim-coffee-script'
Plugin 'rking/ag.vim'
"Plugin 'mileszs/ack.vim'

" Ultisnips Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories=["UltiSnips", "bundle/vim-snippets/UltiSnips", "bundle/ultisnips-rspec/UltiSnips"]

" All of your Plugins must be added before the following line
call vundle#end()            " required
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
set background=dark
set shell=/bin/bash

"ctrlp
set wildignore+=*/tmp/*
set wildignore+=*.jpg,*.gif,*.gem,*.o,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = {
      \   'types': {
      \     1: ['.git', 'git ls-files --cached --others --exclude-standard %s'],
      \   },
      \   'fallback': 'ag --ignore-case --nogroup --nocolor --nobreak --ignore "\.git$\|\.hg$\|\.svn$" -g "" %s'
      \ }

let g:ag_working_path_mode="ra"
let g:ag_prog ='ag --vimgrep --smart-case'
let g:ag_highlight=1
"let g:ackprg = 'ag --vimgrep --smart-case' 

syntax on


map <F2> :NERDTreeToggle<CR>

"Yank file_path to system buffer
nmap <F4> :let @+ = expand("%")<CR>


autocmd FileType ruby,eruby,javascript,jst,go,html,haml,coffee autocmd BufWritePre <buffer> :%s/\s\+$//e 

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
