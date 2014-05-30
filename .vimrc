set nocompatible

" Pathogen

" Clang complete is off because YouCompleteMe replaces it
let g:pathogen_disabled = [ 'clang_complete' ]
execute pathogen#infect()

" Vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle. Required
Bundle 'gmarik/vundle'

" My bundles here:
Bundle 'christoomey/vim-tmux-navigator'

" End Vundle

" Associate *.mac with maxima filetype "
au BufRead,BufNewFile *.mac setfiletype maxima

syntax on " Syntax Highlighting
filetype plugin indent on

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = [ '~/.vim/.ycm_extra_conf.py', '~/Programming/HackerRank/brawl/.ycm_extra_conf.py', '~/Programming/Minotaur/.ycm_extra_conf.py' ]

set tabstop=2
set backspace=indent,eol,start

set autoindent
"set copyindent
set shiftwidth=2
set shiftround
set textwidth=80 "Auto wrap at 80 char line width
set showmatch
set ignorecase
set smartcase " Ignore case when search is all lowercase

set number " Line Numbers
set hidden " When opening new files, keep old one in a buffer
set ruler " Column Numbers

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

" Make double semicolon escape
:inoremap ;; <ESC>

" Enable spell check on text files
autocmd BufNewFile,BufRead *.txt,*.tex,*.latex setlocal spell
set spelllang=en_ca

" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

set exrc    " Enable per-directory .vimrc files
set secure 	" Disable unsafe commands in local .vimrc files

let g:tex_flavor = "latex" " Load .tex files as latex

set foldmethod=syntax
set foldlevelstart=20

" Matching parens is very slow for latex files so disable it.
autocmd filetype tex :NoMatchParen
