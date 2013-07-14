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
