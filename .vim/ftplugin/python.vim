set textwidth=79

" Run linting on save
augroup python_lint
	autocmd!
	autocmd Filetype python autocmd BufWritePost call Flake8()
augroup END
nnoremap <buffer> <silent> <leader>b Oimport pdb; pdb.set_trace()  # XXX<esc>
