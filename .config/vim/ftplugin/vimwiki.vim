setlocal spell
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
" Remove mappings created by vim-unimpaired
" These interfere with the vimwiki "=" mapping, causing vim to wait for a 2nd
" character.
nunmap =p
nunmap =P
nunmap =op
nunmap =o
