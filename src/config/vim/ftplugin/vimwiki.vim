setlocal spell
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
" Remove mappings created by vim-unimpaired
" These interfere with the vimwiki "=" mapping, causing vim to wait for a 2nd
" character.
silent! nunmap =p
silent! nunmap =P
silent! nunmap =op
silent! nunmap =o
