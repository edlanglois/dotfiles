let g:vimwiki_list = [{
	\ 'path': '~/Documents/vimwiki/',
	\ 'template_path': '~/Documents/vimwiki/templates/',
	\ 'template_default': 'default',
	\ 'template_ext': '.html',
	\ 'auto_export': 1,
	\ 'diary_caption_level': 1,
	\}]
let g:vimwiki_auto_chdir = 1

" See help: VimwikiLinkHandler
function! VimwikiLinkHandler(link)
	" Use Vim to open external files with the 'vfile:' scheme.  E.g.:
	"   1) [[vfile:~/Code/PythonProject/abc123.py]]
	"   2) [[vfile:./|Wiki Home]]
	let link = a:link
	if link =~# '^vfile:'
		let link = link[1:]
	else
		return 0
	endif
	let link_infos = vimwiki#base#resolve_link(link)
	if link_infos.filename == ''
		echomsg 'Vimwiki Error: Unable to resolve link!'
		return 0
	else
		exe 'edit ' . fnameescape(link_infos.filename)
		return 1
	endif
endfunction
