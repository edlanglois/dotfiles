setlocal spell
let b:matchparen_cursor_hold = 1
" Exclude lacheck; has false positives that cannot be disabled
let b:ale_linters_ignore = ['lacheck']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
