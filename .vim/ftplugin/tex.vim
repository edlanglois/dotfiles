let g:matchparen_cursor_hold = 1
" Exclude lacheck; has false positives that cannot be disabled
let g:ale_linters_ignore = ['lacheck']
let g:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
