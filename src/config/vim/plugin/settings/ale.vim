" Filetypes for which ALE provides IDE features (completion, go-to, hover)
" through an LSP linter. YCM is disabled for these filetypes (see ycm.vim).
"   python: ty
"   c, cpp: clangd
"   rust:   analyzer
let g:ale_lsp_filetypes = ['python', 'c', 'cpp', 'rust']

" Must be set before ALE is loaded.
let g:ale_completion_enabled = 1
" Only use ALE completion in the filetypes listed above; YCM handles the rest.
augroup ale_completion_filetypes
	autocmd!
	autocmd FileType * let b:ale_completion_enabled =
		\ index(g:ale_lsp_filetypes, &filetype) >= 0
augroup END
" Don't suggest symbols that would need a new import (or #include) to be added
let g:ale_completion_autoimport = 0

let g:ale_fix_on_save = 1
nnoremap <leader>a :ALEFix<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap_error)
nmap <silent> <C-j> <Plug>(ale_next_wrap_error)
" Only run linters on save, not while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" NOTE: ALE linters and fixers are defined in .vim/ftplugin/<filetype>.vim

" Show hover information in a popup window
let g:ale_hover_to_floating_preview = 1

" LSP shortcuts
nmap gt <Plug>(ale_go_to_definition)
nmap gp <Plug>(ale_go_to_type_definition)
nnoremap gs :ALESymbolSearch<Space>
nmap <leader>d <Plug>(ale_hover)
nmap <leader>t <Plug>(ale_hover)
