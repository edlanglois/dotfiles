" Function Keys
" -------------
" F5  - Run Syntastic Check
" F6  - Generate ctags
" F7  - Select buffer
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
Bundle 'bling/vim-airline'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'edkolev/tmuxline.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-scripts/Smart-Tabs'

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
set cinoptions=(0,u0,U0 " Options to cindent (turned on automatically in c files)

set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set textwidth=80 " Auto wrap at 80 char line width
set formatoptions+=t " Auto-wrap text using textwidth
set formatoptions+=c " Auto-wrap comments using textwidth, inserting the
                     " current comment leader automatically.
set formatoptions+=r " Automatically insert the current comment leader after
                     " hitting <Enter> in Insert mode.
set formatoptions+=o " Automatically insert the comment leader after hitting 'o'
                     " or 'O' in Normal mode.
set formatoptions+=q " Allow formatting of comments with "gq"
set formatoptions+=l " Long lines are not broken in insert mode: When a line was
										 " longer than 'textwidth' when the insert command started,
										 " Vim does not automatically format it.
set formatoptions+=1 " Don't break a line after a one-letter word.  It's broken
                     " before it instead (if possible).
set formatoptions+=j " Where it makes sense, remove a comment leader when
                     " joining lines.

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

" Set the highlighted column colour (grey)
highlight ColorColumn ctermbg=233 guibg=#121212
" Highlight the 81st column onward
let &colorcolumn=join(range(81,999),",")

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
nnoremap <F5> :SyntasticCheck<CR>

" Generate CTags
nnoremap <F6> :!echo 'Generating ctags' && ctags -R --c++-kinds=+p --fields=+ialS --extra=+q .<CR>

" Show list of buffers and select one by number
nnoremap <F7> :buffers<CR>:buffer<Space>

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

" Check trailing whitespace with airline (but not mixed tabs/spaces)
let g:airline#extensions#whitespace#checks = ['trailing']

" Automatically strip trailing whitespace on save
fun! <SID>StripTrailingWhitespace()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

autocmd Filetype c,cpp,java,php,ruby,python,html,xml autocmd bufWritePre <buffer> :call <SID>StripTrailingWhitespace()
