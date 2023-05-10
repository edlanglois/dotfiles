" Don't auto-wrap; have an auto-formatter to do that
setlocal formatoptions-=t

" Exclude pylint: slow, must run on files in filesystem
let b:ale_linters_ignore = ['pylint']
" Exclude flake8 if ruff is available
if executable('ruff')
  let b:ale_linters_ignore += ['flake8']
endif

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

function! UpdateTextwidthVars(width)
  let b:ale_python_black_options=printf('--line-length=%d', a:width)
  let b:ale_python_flake8_options=printf('--max-line-length=%d', a:width)
  let b:black_linelength=a:width
endfunction

if exists("g:python_linelength")
  let &l:textwidth=g:python_linelength
  " Call explicitly as the autocmds don't work at this point in setup.
  call UpdateTextwidthVars(g:python_linelength)
endif

" I can't find a way to make this buffer local but it doesn't matter much
" because the variables are irrelevant to non-python files.
augroup textwidth_onset
  autocmd!
  autocmd OptionSet textwidth call UpdateTextwidthVars(v:option_new)
augroup END

" Add an editorconfig hook for UpdateTextwidthVars
" OptionSet does not trigger inside another autocmd so we need this in addition
function! UpdateTextwidthHook(config)
  if !has_key(a:config, 'max_line_length')
    return 0
  endif

  call UpdateTextwidthVars(a:config['max_line_length'])

  return 0   " Return 0 to show no error happened
endfunction
call editorconfig#AddNewHook(function('UpdateTextwidthHook'))

nnoremap <buffer> <silent> <localleader>b Obreakpoint()  # XXX<esc>
