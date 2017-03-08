set nofoldenable " Disable code folding - slow with syntax
syntax sync minlines=50

set conceallevel=2
" Set the conceal highlight to a dark grey.
hi Conceal ctermbg=237

" Left and Right bracket shortcuts
:inoremap <buffer> ;( \left(
:inoremap <buffer> ;) \right)
:inoremap <buffer> ;{ \left\{
:inoremap <buffer> ;} \right\}
:inoremap <buffer> ;[ \left[
:inoremap <buffer> ;] \right]
