let g:ale_fix_on_save = 1
nnoremap <leader>a :ALEFix<CR>
" Only run linters on save, not while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" NOTE: ALE linters and fixers are defined in .vim/ftplugin/<filetype>.vim
