" Function Keys
" -------------
" F5  - Run Syntastic Check
" F6  - Generate ctags
" F8  - Toggle Tagbar
" F11 - Paste Mode

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
Bundle 'tpope/vim-repeat'
Bundle 'majutsushi/tagbar'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'edkolev/tmuxline.vim'

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
let g:ycm_collect_identifiers_from_tags_files = 1

set modeline
set backspace=indent,eol,start

set autoindent
"set copyindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
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

set laststatus=2 " Always show status line

" Search for tags file first in cwd then recursively up to ~/Programming
set tags=./tags;~/Programming

autocmd filetype python set expandtab
autocmd filetype python set tabstop=4
autocmd filetype python set shiftwidth=4
autocmd filetype python set softtabstop=4

" Toggle paste
set pastetoggle=<F11>
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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

set background=dark

" Run syntastic check on F5
nnoremap <slient> <F5> :SyntasticCheck<CR>

" Generate CTags
nnoremap <F6> :!echo 'Generating ctags' && ctags -R --c++-kinds=+p --fields=+ialS --extra=+q .<CR>

" Toggle Tag Bar
nnoremap <F8> :TagbarToggle<CR>

" Buffer navigation with gb and gB
nnoremap gb :bnext<CR>
nnoremap gB :bprev<CR>

" Use non-standard symbols for a better-looking airline.
" Requires installing the powerline fonts:
" https://powerline.readthedocs.org/en/master/installation.html#patched-fonts
let g:airline_powerline_fonts = 1

" Enable buffer display on airline
let g:airline#extensions#tabline#enabled = 1

" Set the airline theme
let g:airline_theme = 'wombat'
