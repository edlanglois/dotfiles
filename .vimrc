" Pathogen
execute pathogen#infect()
syntax on " Syntax Highlighting
filetype plugin indent on

set nocompatible

set tabstop=4
set backspace=indent,eol,start

set autoindent
"set copyindent
set shiftwidth=4
set shiftround
set showmatch
set ignorecase
set smartcase " Ignore case when search is all lowercase

set number " Line Numbers
set hidden " When opening new files, keep old one in a buffer

set nohlsearch
set incsearch

autocmd filetype python set expandtab

" Toggle paste
set pastetoggle=<F11>
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" noremap ; :

let g:clang_auto_select=1
let g:clang_complete_auto=0
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=1
let g:clang_snippets=1
let g:clang_snippets_engine="clang_complete"
let g:clang_conceal_snippets=1
let g:clang_exec="clang"
let g:clang__sort_algor="priority"
let g:clang_complete_macros=0
let g:clang_complete_patterns

