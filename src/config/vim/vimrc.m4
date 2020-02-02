m4_include(user_config.m4)m4_dnl
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
set nocompatible
scriptencoding utf-8
set encoding=utf-8

" Environment
if empty($XDG_CONFIG_HOME)
  let g:xdg_config_home = $HOME . "/.config"
else
  let g:xdg_config_home = $XDG_CONFIG_HOME
endif
if empty($XDG_DATA_HOME)
  let g:xdg_data_home = $HOME . "/.local/share"
else
  let g:xdg_data_home = $XDG_DATA_HOME
endif
if empty($XDG_CACHE_HOME)
  let g:xdg_cache_home = $HOME . "/.cache"
else
  let g:xdg_cache_home = $XDG_CACHE_HOME
endif
" Double slash // causes vim to record file names using the absolute path.
let &directory = g:xdg_cache_home . "/vim/swap//"
let &backupdir = g:xdg_cache_home . "/vim/backup//"
let &undodir = g:xdg_cache_home . "/vim/undo//"
if v:version < 801
	" mkdir(..., 'p') fails if the directory already exists for older vim
	silent! call mkdir(&directory, 'p')
	silent! call mkdir(&backupdir, 'p')
	silent! call mkdir(&undodir, 'p')
else
	call mkdir(&directory, 'p')
	call mkdir(&backupdir, 'p')
	call mkdir(&undodir, 'p')
endif

let &viminfo .= ",'1000,n" . g:xdg_cache_home . "/vim/viminfo"

" Run :PluginInstall to install or update plugins managed by Vundle
" Vundle
filetype off

" Add Vundle to the runtime path
let s:bundledir = g:xdg_data_home . "/vim/bundle"
let &runtimepath .= "," . s:bundledir . "/Vundle.vim"
call vundle#begin(s:bundledir)

" Let Vundle manage Vundle. Required
Plugin 'VundleVim/Vundle.vim'  " MIT

" I have forked some plugins to add my own changes.
" I also fork rarely maintained or unpopular plugins in order to protect myself
" if they become compromised. You can usually find the original from my fork
" on GitHub if you'd rather not trust my copy.

"                                               License
"                                               -------
Plugin 'airblade/vim-gitgutter'               " MIT
Plugin 'alfredodeza/coveragepy.vim'           " Apache 2.0
Plugin 'chrisbra/Recover.vim'                 " Vim
Plugin 'chriskempson/base16-vim'              " MIT
Plugin 'christoomey/vim-tmux-navigator'       " MIT
Plugin 'ctrlpvim/ctrlp.vim'                   " Vim
Plugin 'editorconfig/editorconfig-vim'        " BSD 2-Clause
Plugin 'edkolev/tmuxline.vim',                " MIT
Plugin 'edlanglois/latex-unicoder.vim'        " MIT
Plugin 'edlanglois/vim-gdl-syntax'            " MIT
Plugin 'edlanglois/vim-hledger-syntax'        " MIT
Plugin 'edlanglois/vim-qrc'                   " GPL 3.0
Plugin 'edlanglois/vim-textobj-parameter'     " MIT
Plugin 'edlanglois/vim-tmux-focus-events'     " MIT
Plugin 'edlanglois/vimwiki'                   " MIT
Plugin 'ervandew/supertab'                    " BSD 3-Clause
Plugin 'google/vim-codefmt'                   " Apache 2.0
Plugin 'google/vim-glaive'                    " Apache 2.0
Plugin 'google/vim-maktaba'                   " Apache 2.0
Plugin 'honza/vim-snippets'                   " MIT
Plugin 'hynek/vim-python-pep8-indent'         " CC0 1.0 Universal
Plugin 'Julian/vim-textobj-variable-segment'  " MIT
Plugin 'kana/vim-textobj-user'                " MIT
Plugin 'lervag/vimtex'                        " MIT
Plugin 'lyuts/vim-rtags'                      " BSD 2-Clause
Plugin 'majutsushi/tagbar'                    " Vim
Plugin 'mileszs/ack.vim'                      " Vim
Plugin 'morhetz/gruvbox'                      " MIT
Plugin 'plytophogy/vim-virtualenv'            " Vim
Plugin 'psliwka/vim-smoothie'                 " MIT
Plugin 'rdnetto/YCM-Generator'                " GPL 3.0
Plugin 'SirVer/ultisnips'                     " GPL 3.0
Plugin 'tpope/vim-commentary'                 " Vim
Plugin 'tpope/vim-fugitive'                   " Vim
Plugin 'tpope/vim-repeat'                     " Vim
Plugin 'tpope/vim-surround'                   " Vim
Plugin 'tpope/vim-unimpaired'                 " Vim
Plugin 'vim-airline/vim-airline'              " MIT
Plugin 'vim-airline/vim-airline-themes'       " MIT
Plugin 'vim-python/python-syntax'             " MIT
Plugin 'w0rp/ale'                             " BSD 2-Clause
m4_ifelse(m4_user_config_ALLOW_LICENSE_AGPL,true,
Plugin 'moll/vim-bbye'                        " GNU AGPL v3
)m4_dnl
m4_ifelse(m4_user_config_ALLOW_LICENSE_WTFPL,true,
Plugin 'Konfekt/FastFold'                     " WTFPL (French)
Plugin 'scrooloose/nerdtree'                  " WTFPL
Plugin 'Xuyuanp/nerdtree-git-plugin'          " WTFPL
)m4_dnl
m4_ifelse(m4_user_config_ALLOW_LICENSE_NONE,true,
Plugin 'edlanglois/fish-syntax'               " None
Plugin 'edlanglois/vim-HiLinkTrace'           " None
Plugin 'JamshedVesuna/vim-markdown-preview'   " None
" Must go after nerdtree
Plugin 'edlanglois/nerdtree-chmod'            " None
)m4_dnl
m4_ifelse(m4_user_config_LIGHTWEIGHT,true,,
" Heavywight plugins
Plugin 'Valloric/YouCompleteMe'               " GPL 3.0
)m4_dnl

" End Vundle
call vundle#end()

" Replace default vim config with vim_config_dir in the runtimepath
set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
let g:vim_config_dir = g:xdg_config_home . "/vim"
let &runtimepath = g:vim_config_dir . "," . &runtimepath .
  \ "," . g:vim_config_dir . "/after"

" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

call glaive#Install()

filetype plugin indent on
syntax on " Syntax Highlighting

set modeline
set backspace=indent,eol,start

set nojoinspaces     " Insert 1, not 2, spaces after period when joining text.

" Tabs and indentation
set autoindent
set cinoptions=(0,u0,U0 " Options to cindent (turned on automatically in c files)
set indentkeys=0{,0},0),0#,!^F,o,O,e " Never reindent nonempty lines when typing.

set tabstop=2
set shiftwidth=2
set softtabstop=-1   " Virtual tab size when expanding to space. -1 = shiftwidth
set noshiftround     " Do not round indent to a multiple of shiftwidth
set noexpandtab      " Tabs do not expand to spaces.
set copyindent       " Default to same indentation structure as previous line

set textwidth=80     " Auto wrap at 80 char line width
" Note: I occasionally swap the t setting. I'll start recording what filetype
" I have in mind when doing so.
"  * vimwiki: +t
set formatoptions+=t " Auto-wrap text using textwidth
set formatoptions+=c " Auto-wrap comments using textwidth, inserting the
                     " current comment leader automatically.
set formatoptions+=r " Automatically insert the current comment leader after
                     " hitting <Enter> in Insert mode.
set formatoptions-=o " Automatically insert the comment leader after hitting 'o'
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

" Filetype plugins tend to mess with these formatoptions.
" In particular, most set -=t, +=croql
" Re-apply the change we want
augroup myformat
	autocmd!
	autocmd BufNewFile,BufRead * setlocal formatoptions -=o
augroup END

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

set wildmenu  " Show a menu when autocompleting vim commands

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
hi SpecialKey ctermfg=234 guifg=grey20

" HACK: Fix undercurl
" t_Cs (undercurl) is being set on terminals that do not support it, so change
" to empty string causing vim to fall back to underline.
let &t_Cs=""
let &t_Ce=""

let &spelllang = tolower("m4_user_config_LANG")
let &spellfile = g:xdg_data_home . "/vim/spell/en.utf-8.add"

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
" let g:tex_conceal=""

" Vimpager
let g:less = {}
" Disable less compatibility mode
let g:less.enabled = 0

" Open help with a vertical split
cabbrev help vert help
