syntax on
filetype plugin indent on
imap fd <ESC>
nmap fd <ESC>
vmap fd <ESC>
omap fd <ESC>
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
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'neovimhaskell/haskell-vim'

call plug#end()

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

" Rust
let g:rustfmt_autosave = 1
