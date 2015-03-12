let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
exe 'source' join([s:path, 'tex.vim'], '/')
