let g:ycm_global_ycm_extra_conf = g:vim_config_dir . "/ycm_extra_conf.py"
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
" YCM completion triggers frequently on large tex files and is too slow
let g:ycm_filetype_blacklist = {
	\ 'tex': 1
	\}

" YCM shortcuts
nnoremap gt :YcmCompleter GoTo<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
