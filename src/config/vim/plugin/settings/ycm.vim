" YCM provides identifier-based completion for filetypes that do not have an
" ALE LSP linter configured. Semantic features are handled by ALE (ale.vim).
let g:ycm_seed_identifiers_with_syntax = 1
" YCM completion triggers frequently on large tex files and is too slow
let g:ycm_filetype_blacklist = {
	\ 'tex': 1
	\}
" Disable YCM where ALE provides completion
for s:ft in get(g:, 'ale_lsp_filetypes', [])
	let g:ycm_filetype_blacklist[s:ft] = 1
endfor
unlet! s:ft

" Remove <Tab> from mappings
let g:ycm_key_list_select_completion = [ '<Down>' ]
let g:ycm_key_list_previous_completion = [ '<Up>' ]
