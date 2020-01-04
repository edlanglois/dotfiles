let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Don't switch buffers when opening with <cr> (Default is 'Et')
let g:ctrlp_switch_buffer = 't'
" Use git or mercurial to generate list of files if possible
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others && git submodule --quiet foreach --recursive ''for file in $(git ls-files --cached --exclude-standard --others); do echo "$path/$file"; done'''],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
