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
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Trevoke/ultisnips-rspec'
" Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-surround'
"Plugin 'Lokaltog/vim-powerline'
Plugin 'elixir-lang/vim-elixir'
Plugin 'tpope/vim-rails'
Plugin 'pangloss/vim-javascript'
Plugin 'dsawardekar/ember.vim'

:set tags=./tags;
let g:ctrlp_extensions=["tag"]
"let g:easytags_dynamic_files=1
let g:easytags_async=1
let g:easytags_auto_update=1
"let g:easytags_autorecurse = 1

" Ultisnips Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsUsePythonVersion = 2

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" " If you want :UltiSnipsEdit to split your window.
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
set nocompatible
set laststatus=2
set noshowmode

let g:indent_guides_start_level = 2
set background=dark
set shell=/bin/bash

"ctrlp
set wildignore+=*/tmp/*
set wildignore+=vendor/bundle,vendor/ruby,node_modules,deps
set wildignore+=tags
set wildignore+=bower_components
set wildignore+=*.png,*.jpg,*.gif,*.gem,*.o,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:Powerline_symbols = 'fancy'

syntax on


map <F2> :NERDTreeToggle<CR>




autocmd FileType ruby,eruby,javascript,jst,go autocmd BufWritePre <buffer> :%s/\s\+$//e 

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
"

source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
