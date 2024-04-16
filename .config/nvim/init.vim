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

" Windows
nnoremap <leader>w/ <c-w>v
nnoremap <leader>wd <c-w>q
nnoremap <leader>1 <c-w>h
nnoremap <leader>2 <c-w>l
nnoremap <c-[> :tabp<CR>
nnoremap <c-]> :tabn<CR>
nnoremap <leader><tab> :b#<CR>

" File system
nnoremap <C-x><C-f> :edit .<CR>
nnoremap <C-x><C-s> :w<CR>
