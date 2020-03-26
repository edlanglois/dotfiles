if exists("g:python_linelength")
  let &l:textwidth=g:python_linelength
endif
" Exclude pylint: slow, must run on files in filesystem
let b:ale_linters_ignore = ['pylint']
let b:ale_fixers = ['black', 'isort', 'trim_whitespace']

let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_mypy_options='--ignore-missing-imports'
let g:ale_python_mypy_options.=' --follow-imports="silent"'
" By default mypy creates .mypy_cache in the directory in which it is run.
" I prefer that it use XDG cache instead.
" I don't know if there will be a problem with multiple projects sharing the
" same cache directory. Based on inspection of the cache directory contents,
" issues are only possible in the event of filename conflicts, I'm not sure if
" the actually will happen that case.
" Use a sqlite DB for the cache in an attempt to mitigate concurrent access
" issues.
let g:ale_python_mypy_options.=' --cache-dir="'.g:xdg_cache_home.'/mypy"'
let g:ale_python_mypy_options.=' --sqlite-cache'

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

nnoremap <buffer> <silent> <localleader>b Obreakpoint()  # XXX<esc>
