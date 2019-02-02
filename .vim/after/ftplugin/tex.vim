syntax sync minlines=50

set conceallevel=2
" Set the conceal highlight to a dark grey.
hi Conceal ctermbg=237

" Left and Right bracket shortcuts
inoremap <buffer> ;( \left(
inoremap <buffer> ;) \right)
inoremap <buffer> ;{ \left\{
inoremap <buffer> ;} \right\}
inoremap <buffer> ;[ \left[
inoremap <buffer> ;] \right]
inoremap <buffer> ;< \left\langle
inoremap <buffer> ;> \right\rangle
inoremap <buffer> ;<BSlash> \left<Bar>
inoremap <buffer> ;<Bar> \right<Bar>
inoremap <buffer> ;m \middle<Bar>
inoremap <buffer> ;<Bslash><BSlash> \left\<Bar>
inoremap <buffer> ;<Bslash><Bar> \right\<Bar>
