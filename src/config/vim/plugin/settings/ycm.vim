let g:ycm_global_ycm_extra_conf = g:vim_config_dir . "/ycm_extra_conf.py"
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
nnoremap <leader>t :YcmCompleter GetType<CR>

" make YCM compatible with UltiSnips
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p', '<Up>']
