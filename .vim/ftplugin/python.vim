if exists("g:python_linelength")
  let &l:textwidth=g:python_linelength
endif
" Exclude pylint: slow, must run on files in filesystem
let b:ale_linters_ignore = ['pylint']
let b:ale_fixers = ['black', 'isort', 'trim_whitespace']
let b:ale_python_black_options=printf('--line-length=%d', &l:textwidth)
let b:ale_python_flake8_options=printf('--max-line-length=%d', &l:textwidth)
let b:black_linelength=&l:textwidth

nnoremap <buffer> <silent> <localleader>b Oimport pdb; pdb.set_trace()  # XXX<esc>
