if exists("g:python_linelength")
  let &l:textwidth=g:python_linelength
endif
let g:ale_python_black_options=printf('--line-length=%d', &l:textwidth)
let g:black_linelength=&l:textwidth

nnoremap <buffer> <silent> <localleader>b Oimport pdb; pdb.set_trace()  # XXX<esc>
