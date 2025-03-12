let g:ycm_seed_identifiers_with_syntax = 1
" YCM completion triggers frequently on large tex files and is too slow
let g:ycm_filetype_blacklist = {
	\ 'tex': 1
	\}

" Remove <Tab> from mappings
let g:ycm_key_list_select_completion = [ '<Down>' ]
let g:ycm_key_list_previous_completion = [ '<Up>' ]

" YCM shortcuts
nnoremap gt :YcmCompleter GoTo<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
nnoremap <leader>s <Plug>(YCMFindSymbolInWorkspace)
