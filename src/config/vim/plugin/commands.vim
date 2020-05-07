"" Custom Commands
" CommandCabbr enables arbitrary command abbreviations (including lower case)
function! CommandCabbr(abbreviation, expansion)
	execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction
command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)

" Reset the location list to default size (close it then re-open it)
command! Lresize lclose|lopen
CommandCabbr lresize Lresize
CommandCabbr lrs Lresize

" Tex import sorting (ignores everything before package name)
command! -range Tsort <line1>,<line2>sort i /[^{]*{/

" Recursive grep
" Usage:
"    :Gr regex --extra-args-to-grep
command! -nargs=+ Gr :grep! <args> -I -R * | :copen

" Open help with a vertical split
cabbrev help vert help
