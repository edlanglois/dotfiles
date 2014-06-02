" Run :PluginInstall to install or update plugins managed by Vundle
set nocompatible

" Vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle. Required
Bundle 'gmarik/Vundle.vim'

" My bundles here:
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'

" End Vundle
call vundle#end()

" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Associate *.mac with maxima filetype "
au BufRead,BufNewFile *.mac setfiletype maxima

syntax on " Syntax Highlighting
filetype plugin indent on

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = [ '~/.vim/.ycm_extra_conf.py', '~/Programming/*']

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
autocmd filetype tex set nofoldenable " Also disable code folding - slow on tex

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
