if exists("g:python_linelength")
  let &l:textwidth=g:python_linelength
endif
" Exclude pylint: slow, must run on files in filesystem
let b:ale_linters_ignore = ['pylint']
let b:ale_fixers = ['black', 'isort', 'trim_whitespace']

function! UpdateTextwidthVars()
  let b:ale_python_black_options=printf('--line-length=%d', &l:textwidth)
  let b:ale_python_flake8_options=printf('--max-line-length=%d', &l:textwidth)
  let b:black_linelength=&l:textwidth
endfunction
call UpdateTextwidthVars()

" I can't find a way to make this buffer local but it doesn't matter much
" because the variables are irrelevant to non-python files.
augroup textwidth_onset
  autocmd! *
  autocmd OptionSet textwidth :call UpdateTextwidthVars()
augroup END

nnoremap <buffer> <silent> <localleader>b Oimport pdb; pdb.set_trace()  # XXX<esc>
