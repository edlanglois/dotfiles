let g:unicoder_cancel_normal = 1
" let g:unicoder_no_map = 1
" map <leader>u <Plug>Unicoder
inoremap <C-l> <C-o>:call unicoder#start(1)<CR>
nnoremap <leader>u :call unicoder#start(1)<CR>
