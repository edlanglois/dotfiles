setlocal spell

set expandtab
set tabstop=2
set shiftwidth=2

" Vimtex paren matching is too slow.
let g:vimtex_matchparen_enabled = 0
" Exclude lacheck; has false positives that cannot be disabled
let b:ale_linters_ignore = ['lacheck']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']

nnoremap <leader>b :execute
	\ 'silent w !dblp-makebib '
	\ . shellescape(expand('%:p:h') . '/dblp.bib')
	\ . ' 2>/dev/null'<CR>

" Conceal slows down large documents
setlocal conceallevel=0

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

" Setup the PDF viewer to use with vimtex
if executable('okular')
	let g:vimtex_view_general_viewer = 'okular'
	let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
	let g:vimtex_view_general_options_latexmk = '--unique'
elseif executable('evince')
	let g:vimtex_view_general_viewer = 'evince'
endif
