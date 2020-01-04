" Vim syntax file
" Language:	M4 + A 2nd filetype
" Maintainer:	Eric Langlois

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax="m4_plus"
endif

" Fallback to default m4 syntax if no secondary syntax
if !exists('b:second_syntax')
	finish
endif

" Load the secondary syntax
let s:synfile = "syntax/". b:second_syntax .".vim"
execute 'runtime! '.fnameescape(s:synfile)

if exists("b:current_syntax")
	unlet b:current_syntax
endif

if main_syntax == "m4_plus"
  unlet main_syntax
endif

" Without current_syntax set, should load the default .m4 syntax after
" returning.
