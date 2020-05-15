" Append -dynamic to default options.
" See https://wiki.archlinux.org/index.php/Haskell#Problems_with_linking
let g:ale_haskell_ghc_options = "-fno-code -v0 -dynamic"

let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']

set expandtab
