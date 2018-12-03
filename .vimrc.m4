m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl
" Function Keys
" -------------
" F3  - Toggle Tagbar
" F4  - Select buffer
" F5  - YCM Recompile and Regenerate diagnostics
" F6  - Generate ctags
" F7  - Python lint
" F10 - Syntax Group under cursor
" F11 - Toggle paste
set shell=/bin/bash " Vim doesn't like fish

" Run :PluginInstall to install or update plugins managed by Vundle
set nocompatible
scriptencoding utf-8
set encoding=utf-8

" Vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle. Required
Plugin 'VundleVim/Vundle.vim'

" I have forked some plugins to add my own changes.
" I also fork rarely maintained or unpopular plugins in order to protect myself
" if they become compromised. You can usually find the original from my fork
" on GitHub if you'd rather not trust my copy.

Plugin 'airblade/vim-gitgutter'
Plugin 'alfredodeza/coveragepy.vim'
Plugin 'ambv/black'
Plugin 'chrisbra/Recover.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'edkolev/tmuxline.vim',
Plugin 'edlanglois/fish-syntax'
Plugin 'edlanglois/prolog.vim'
Plugin 'edlanglois/vim-gdl-syntax'
Plugin 'edlanglois/vim-HiLinkTrace'
Plugin 'edlanglois/vim-qrc'
Plugin 'edlanglois/vim-textobj-parameter'
Plugin 'edlanglois/vim-tmux-focus-events'
Plugin 'edlanglois/vimwiki'
Plugin 'ervandew/supertab'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'google/vim-maktaba'
Plugin 'honza/vim-snippets'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'Julian/vim-textobj-variable-segment'
Plugin 'kana/vim-textobj-user'
Plugin 'Konfekt/FastFold'
Plugin 'lervag/vimtex'
Plugin 'lyuts/vim-rtags'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'moll/vim-bbye'
Plugin 'morhetz/gruvbox'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'peterhoeg/vim-qml'
Plugin 'rdnetto/YCM-Generator'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-python/python-syntax'
Plugin 'w0rp/ale'
Plugin 'Xuyuanp/nerdtree-git-plugin'
m4_ifelse(m4_user_config_LIGHTWEIGHT,true,,
" Heavywight plugins
Plugin 'Valloric/YouCompleteMe'
)m4_dnl
" Must go after nerdtree
Plugin 'edlanglois/nerdtree-chmod'

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

call glaive#Install()

"" Custom Commands
" CommandCabbr enables arbitrary command abbreviations (including lower case)
function! CommandCabbr(abbreviation, expansion)
	execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction
command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)

" Reset the location list to default size (close it then re-open it)
command! Lresize lclose|lopen
CommandCabbr lresize Lresize
CommandCabbr lrs Lresize

" Tex import sorting (ignores everything before package name)
command! -range Tsort <line1>,<line2>sort i /[^{]*{/

" Recursive grep
" Usage:
"    :Gr regex --extra-args-to-grep
command! -nargs=+ Gr :grep! <args> -I -R * | :copen

" Filetype associations
au BufRead,BufNewFile *.mac setfiletype maxima
au BufRead,BufNewFile *.make setfiletype make
au BufRead,BufNewFile *.prototxt setfiletype yaml

syntax on " Syntax Highlighting
filetype plugin indent on

" Enable most highlighting options for vim-python/python-syntax plugin
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = [ '~/.vim/.ycm_extra_conf.py', '~/Programming/*']
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1,
      \ 'tex' : 1,
      \ 'rnoweb' : 1
      \}

" YCM shortcuts
nnoremap gt :YcmCompleter GoTo<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>

" make YCM compatible with UltiSnips
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p', '<Up>']

" Supertab maps tab so use ctrl-j instead, same as forward in snippet.
let g:UltiSnipsExpandTrigger = '<c-j>'

" Default python line length. Overrides textwidth
let g:python_linelength=88

let g:ultisnips_python_style = 'google'

let g:ale_fix_on_save = 1
nnoremap <leader>a :ALEFix<CR>
let g:ale_lint_on_text_changed = 'never'
" Exclude the folling linters:
" python:
"   pylint - slow, must run on files in filesystem
" latex:
"   lacheck - false positives that cannot be disabled
let g:ale_linters_ignore = {
\   'python': ['pylint'],
\   'tex': ['lacheck'],
\}
let g:ale_fixers = {
\    'python': ['black', 'isort']
\}
" Don't run pylint on testing python files.
let g:ale_pattern_options = {
\    'test_.*\.py': {'ale_linters': ['flake8', 'mypy']},
\}

let g:clighter_cursor_hl_default = 0 " Cursor highlighting is somewhat slow.

let g:hilinks_map = 0  " Don't create \hlt mapping for hilinks

set modeline
set backspace=indent,eol,start

set autoindent
set cinoptions=(0,u0,U0 " Options to cindent (turned on automatically in c files)
set indentkeys=0{,0},0),0#,!^F,o,O,e " Never reindent nonempty lines when typing.

set nojoinspaces     " Insert 1, not 2, spaces after period when joining text.

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set textwidth=80     " Auto wrap at 80 char line width
set formatoptions-=t " Auto-wrap text using textwidth
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
set formatoptions+=n " Proper indendation with lists when auto-formatting.
                     " e.g. numbered lists or bullet lists
set formatoptions+=2 " In multiline paragraphs, use the indentation level of the
                     " 2nd line.

set showmatch

set number " Line Numbers
" set relativenumber " Hybrid number mode
" Disabled because it's very slow in some cases (e.g. .tex files)

set hidden " When opening new files, keep old one in a buffer
set ruler " Column Numbers

" No bell / flash. Set to visualbell then make visualbell do nothing.
set visualbell t_vb=

set hlsearch
set incsearch
set ignorecase
set smartcase

set scrolloff=10

set laststatus=2 " Always show status line

set foldmethod=indent
set foldlevel=99

if has('termguicolors')
	" See :help xterm-true-color
	set t_8f=[38;2;%lu;%lu;%lum
	set t_8b=[48;2;%lu;%lu;%lum
	set termguicolors " Use 24-bit colours
endif
set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
hi Normal ctermbg=black guibg=black ctermfg=white guifg=white
hi Comment ctermfg=darkcyan guifg=darkcyan

set colorcolumn=+1  " Highlight the column after textwidth

" Search for tags file first in cwd then recursively up to ~/Programming
set tags=./tags;~/Programming

" Display tabs as ⇥
set list
set listchars=tab:⇥\ ,
" And show them as dark grey
hi SpecialKey ctermfg=8 guifg=grey50

" Toggle paste
set pastetoggle=<F11>

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" <C-l> was redraw, make <leader>r the new redraw
nnoremap <leader>r :redraw!<cr>

" Execute the current file
nnoremap <leader>e :!"%:p"<cr>

" Mappings (from Learn Vimscript the Hard Way)
" Use kj as <esc> and `^ to prevent the cursor from moving
inoremap kj <Esc>`^
" Also save
" inoremap lkj <Esc>`^:w<CR>
" Also save and quit
" inoremap ;lkj <Esc>:wq<CR>

" Use <leader><c-u> to convert a word to upper case mode.
inoremap <leader><c-u> <esc>viwUhea
nnoremap <leader><c-u> viwUhe

" Use <leader>sv to re-source VIMRC
nnoremap <leader>sv :source $MYVIMRC<cr>

" Move to beginning of line with H and end with L
nnoremap H ^
nnoremap L $

" HACK: Fix undercurl
" t_Cs (undercurl) is being set on terminals that do not support it, so change
" to empty string causing vim to fall back to underline.
let &t_Cs=""
let &t_Ce=""

augroup spelling
	autocmd!
	" Enable spell check on text files
	autocmd FileType text,markdown,vim,vimwiki setlocal spell
augroup END
set spelllang=en_ca,en

" Open spelling suggestions with <leader>s
:nnoremap <leader>s ea<C-X><C-S>

" Clear current search highlight
:nnoremap <leader>h :nohlsearch<CR>

" Go to current location in the location / error list
:nnoremap <leader>l :ll<CR>
:nnoremap <leader>c :cc<CR>


augroup preview
	autocmd!
	" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
	autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END

set exrc    " Enable per-directory .vimrc files
set secure  " Disable unsafe commands in local .vimrc files

" For vim-latex
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a single file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" Also for vim-latex
let &runtimepath.=',$VIM/vimfiles'

let g:tex_flavor = "latex" " Load .tex files as latex
let g:tex_conceal=""

" Vimpager
let g:less = {}
" Disable less compatibility mode
let g:less.enabled = 0

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Don't switch buffers when opening with <cr> (Default is 'Et')
let g:ctrlp_switch_buffer = 't'
" Use git or mercurial to generate list of files if possible
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others && git submodule --quiet foreach --recursive ''for file in $(git ls-files --cached --exclude-standard --others); do echo "$path/$file"; done'''],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" Toggle NERDTree
nnoremap <leader>f :NERDTreeToggle<CR>

" Toggle Tag Bar
nnoremap <F3> :TagbarToggle<CR>

" Show list of buffers and select one by number
nnoremap <F4> :buffers<CR>:buffer<Space>

" Refresh YCM diagnostics on F5
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" Generate CTags
nnoremap <F6> :!echo 'Generating ctags' && ctags -R --fields=+ialsSfk --extra=+q --options=.ctags.conf --verbose .<CR>

" Syntax group under cursor"
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Buffer navigation with gb and gB
nnoremap gb :bnext<CR>
nnoremap gB :bprev<CR>

" Resize panes with ,. instead of <>
nnoremap <C-W>, <C-W><
nnoremap <C-W>. <C-W>>

" Saves the current file using sudo
cnoremap w!! w ! sudo tee > /dev/null %

" Next/Last (,{ operator mode mappings.
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi}<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap al( :<c-u>normal! F)va(<cr>
onoremap an{ :<c-u>normal! f{va{<cr>
onoremap al{ :<c-u>normal! F}va}<cr>

" Vimtex paren matching is too slow.
let g:vimtex_matchparen_enabled=0

" Enable buffer display on airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" Enable ALE integration
let g:airline#extensions#ale#enabled = 1

m4_ifdef(??[[<<m4_env_config_NETUSER>>]]??,m4_dnl
" Disable version control integration (slow when filesystem is slow)
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#fugitiveline#enabled = 0
)m4_dnl

" Check trailing whitespace with airline (but not mixed tabs/spaces)
let g:airline#extensions#whitespace#checks = ['trailing']

" Set the airline theme
let g:airline_theme = 'wombat'

m4_ifelse(m4_user_config_POWERLINE_SYMBOLS,true,
" Use non-standard symbols for a better-looking airline.
" Requires installing the powerline fonts:
" https://powerline.readthedocs.org/en/master/installation.html#patched-fonts
let g:airline_powerline_fonts = 1
let g:tmuxline_powerline_separators = 1,
" Use standard symbols. Don't have to install special font.
let g:airline_powerline_fonts = 0
let g:tmuxline_powerline_separators = 0
)

" Tmuxline based on the 'powerline' preset but with 12 hour time.
let g:tmuxline_preset = {
	\'a'    : '#S',
	\'b'    : '#F',
	\'win'  : ['#I', '#W'],
	\'cwin' : ['#I', '#W'],
	\'y'    : ['%Y-%m-%d', '%I:%M %p'],
	\'z'    : '#h',
	\'options' : {'status-justify' : 'left'},
\}

let NERDTreeIgnore = [
	\'\.pyc$',
	\'\.egg-info',
	\'__pycache__',
	\]

" Don't update the NERDTree git flags (nerdtree-git-plugin) on write.
" The update interferes with python-mode's lint-on-write.
let NERDTreeUpdateOnWrite=0

" Vim Markdown Preview
let vim_markdown_preview_hotkey='<leader>lv'
let vim_markdown_preview_use_xdg_open=1

" Vimwiki
let g:vimwiki_list = [{
	\ 'path': '~/Documents/vimwiki/',
	\ 'template_path': '~/Documents/vimwiki/templates/',
	\ 'template_default': 'default',
	\ 'template_ext': '.html',
	\ 'auto_export': 1,
	\ 'diary_caption_level': 1,
	\}]
let g:vimwiki_auto_chdir = 1

" Ack / Ag
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

augroup strip_whitespace
	autocmd!
	autocmd Filetype
		\ c,
		\cpp,
		\html,
		\java,
		\php,
		\python,
		\qml,
		\ruby,
		\xml
		\ autocmd BufWritePre <buffer> StripWhitespace
augroup END

" Source files from .vim/vimrc.d
source ~/.vim/vimrc.d/vimwiki.vim
