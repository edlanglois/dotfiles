set nofoldenable " Disable code folding - slow with syntax
syntax sync minlines=50

set conceallevel=2

" Left and Right bracket shortcuts
:inoremap <buffer> ;( \left(
:inoremap <buffer> ;) \right)
:inoremap <buffer> ;{ \left\{
:inoremap <buffer> ;} \right\}
:inoremap <buffer> ;[ \left[
:inoremap <buffer> ;] \right]

" Parenthesis matching is very slow
:NoMatchParen
