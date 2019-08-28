setlocal spell
" Vimtex paren matching is too slow.
let g:vimtex_matchparen_enabled = 0
" Exclude lacheck; has false positives that cannot be disabled
let b:ale_linters_ignore = ['lacheck']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']

nnoremap <leader>b :execute
	\ 'silent w !dblp-makebib '
	\ . shellescape(expand('%:p:h') . '/dblp.bib')
	\ . ' 2>/dev/null'<CR>
