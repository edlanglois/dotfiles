set textwidth=79

" Run linting on save
augroup python_lint
	autocmd!
	autocmd BufWritePost <buffer> call Flake8()
augroup END
nnoremap <buffer> <silent> <leader>b Oimport pdb; pdb.set_trace()  # XXX<esc>
