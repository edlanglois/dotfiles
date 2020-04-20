" Toggle paste
set pastetoggle=<F11>

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize panes with ,. instead of <>
nnoremap <C-W>, <C-W><
nnoremap <C-W>. <C-W>>

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

" Vertical movement in soft-wrapped lines
" https://stackoverflow.com/a/21000307
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Move to beginning of line with H and end with L
nnoremap H ^
nnoremap L $

" Open spelling suggestions with <leader>s
nnoremap <leader>s ea<C-X><C-S>

" Clear current search highlight
nnoremap <leader>h :nohlsearch<CR>

" Go to current location in the location / error list
nnoremap <leader>l :ll<CR>
nnoremap <leader>c :cc<CR>

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

" Sort
vnoremap <leader>s :sort i<cr>
