" Pathogen
let g:pathogen_disabled = [ 'clang_complete', 'command-t' ]
execute pathogen#infect()
syntax on " Syntax Highlighting
filetype plugin on

set nocompatible

set tabstop=2
set backspace=indent,eol,start

set autoindent
"set copyindent
set shiftwidth=2
set shiftround
set showmatch
set ignorecase
set smartcase " Ignore case when search is all lowercase

set number " Line Numbers
set hidden " When opening new files, keep old one in a buffer

set nohlsearch
set incsearch

set scrolloff=10

autocmd filetype python set expandtab

" Toggle paste
set pastetoggle=<F11>
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" noremap ; :

"let g:clang_user_options="|| exit 0"
"
"let g:clang_auto_select=1
"let g:clang_complete_auto=1
"let g:clang_complete_copen=0
"let g:clang_hl_errors=1
"let g:clang_periodic_quickfix=0
"let g:clang_snippets=1
"let g:clang_snippets_engine="clang_complete"
"let g:clang_conceal_snippets=1
"let g:clang_close_preview=1
"let g:clang_exec="clang"
"let g:clang_complete_macros=1
"let g:clang_complete_patterns=0
"
"" Close preview window
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
