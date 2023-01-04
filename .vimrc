syntax on
filetype plugin indent on
imap fd <ESC>
nmap fd <ESC>
vmap fd <ESC>
omap fd <ESC>
set clipboard=unnamed
set number relativenumber
set so=999
set expandtab
set tabstop=2
set softtabstop=4
set shiftwidth=2

let mapleader = "\<Space>"

call plug#begin()

" GUI
Plug 'itchyny/lightline.vim'
Plug 'roman/golden-ratio'
Plug 'andymass/vim-matchup'
Plug 'scrooloose/nerdtree'

" Sematic
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" General
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'

" Languages
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'NoahTheDuke/vim-just'

" Keyboard
Plug 'folke/which-key.nvim'

call plug#end()

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" Windows
nnoremap <leader>w/ <c-w>v
nnoremap <leader>wd <c-w>q
nnoremap <leader>1 <c-w>h
nnoremap <leader>2 <c-w>l
nnoremap <c-[> :tabp<CR>
nnoremap <c-]> :tabn<CR>
nnoremap <leader><tab> :b#<CR>

" File system
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-x><C-f> :edit .<CR>
nnoremap <C-x><C-s> :w<CR>
