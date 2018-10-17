if exists("g:python_linelength")
  let &l:textwidth=g:python_linelength
  let g:ale_python_black_options=printf('--line-length=%d', g:python_linelength)
  let g:black_linelength=g:python_linelength
endif

nnoremap <buffer> <silent> <localleader>b Oimport pdb; pdb.set_trace()  # XXX<esc>
