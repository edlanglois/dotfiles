m4_include(user_config.m4)m4_dnl

let g:snips_author = "m4_user_config_NAME"

" Snippets from vim-snippets as well as my custom snippets
" This variable defaults to ["UltiSnips"] which does a recursive search of
" directories in the vim runtimepath.
" Setting these avoids the search but will miss any snippets in other plugins.
" vim-snippets/snippets seems to be included regardless of the value of this
" variable but /UltiSnips takes precedence when included.
let g:UltiSnipsSnippetDirectories = [
			\ g:plugin_dir . "/vim-snippets/UltiSnips",
			\ g:vim_config_dir . "/UltiSnips"
			\ ]

" My custom snippets for :UltiSnipsEdit
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit =
	\ g:vim_config_dir . "/UltiSnips"

" YCM maps tab so use ctrl-j instead, same as forward in snippet.
let g:UltiSnipsExpandTrigger = '<c-j>'

let g:ultisnips_python_style = 'google'
