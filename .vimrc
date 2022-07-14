set nocompatible
filetype off

"set rtp+=~/.vim/bundle/Vundle.vim
"set rtp+=/usr/homebrew/opt/fzf

call plug#begin('~/.vim/plugged')

"Other Plugins
Plug 'scrooloose/nerdtree'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Trevoke/ultisnips-rspec'
"Plug 'xolox/vim-misc'
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
"Plug 'rking/ag.vim'
"
"FZF Fuzzy File Searcher
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'mileszs/ack.vim'
Plug 'ap/vim-css-color'

if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'
end

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

set colorcolumn=80

set foldmethod=syntax
set foldlevelstart=99

let g:indent_guides_start_level = 2
set shell=$SHELL

colorscheme monokai

"ctrlp
set wildignore+=*/tmp/*
set wildignore+=*.jpg,*.gif,*.gem,*.o,*.so,*.swp,*.zip,*.log
"let g:ctrlp_custom_ignore = 'node_modules'
"let g:ctrlp_working_path_mode = 'r'
"let g:ctrlp_user_command = {
"      \   'types': {
"      \     1: ['.git', 'git ls-files --cached --others --exclude-standard %s'],
"      \   },
"      \   'fallback': 'ag --ignore-case --nogroup --nocolor --nobreak --ignore "\.git$\|\.hg$\|\.svn$" -g "" %s'
"      \ }
"let g:ctrlp_user_command = 'ag --vimgrep --ignore-case --ignore "\.git$\|\.hg$\|\.svn$" -g "" %s'

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

let g:airline_inactive_collapse=1
let g:airline#extensions#branch#displayed_head_limit=15

map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFind<CR>

"Yank file_path to system buffer
nmap <F4> :let @+ = expand("%")<CR>

"fzf
let g:fzf_command_prefix="Fzf"
nmap <C-f> :FZF<CR>
nmap <C-p> :FZF<CR>

"let g:python3_host_prog="/Users/carlos/.virtualenvs/neovim/bin/python"

if exists(':tnoremap')
  tnoremap <Esc> <C-\><C-n>
endif

command Bterm bo 10sp +term

if has('nvim')
lua <<EOF
  require'lspconfig'.solargraph.setup{}

  local nvim_lsp = require('lspconfig')

  ---- See `:help vim.diagnostic.*` for documentation on any of the below functions
  --local opts = { noremap=true, silent=true }
  --vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  --vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  --vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  --vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Enable complection triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    --buf_set_keymap('n', '<space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    --buf_set_keymap('n', '<space>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    --buf_set_keymap('n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    --buf_set_keymap('n', '<space>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    --buf_set_keymap('n', '<space>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    --buf_set_keymap('n', '<space>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    --buf_set_keymap("n", "<space>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  local servers = { "solargraph" }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = { debounce_text_changes = 150, }
    }
  end
EOF

"nvim-comp setup"
lua <<EOF
  vim.o.completeopt = "menu,menuone,noselect"

  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users
        vim.fn["UltSnips#Anon"](args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true}),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('gitcommit', {
    spirces = cmp.config.sources({
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['solargraph'].setup {
    capabilities = capabilities,
    settings = {
      commandPath = os.execute("chruby-exec 3.1.2 -- which solargraph"),
      diagnostics = true,
      completion = true
    }
  }
EOF
end

autocmd FileType ruby,eruby,python,elixir,exs,javascript,java,jst,go,html,haml,coffee autocmd BufWritePre <buffer> :%s/\s\+$//e 

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
