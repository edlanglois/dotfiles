" Custom filetype mappings
if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	" au! commands to set the filetype go here
	au! BufNewFile,BufRead .latexmkrc            setf perl

	" M4 Files
	au! BufNewFile,BufRead *.sh.m4,*.bashrc.m4   call s:FTm4("bash")
	au! BufNewFile,BufRead *.hgrc.m4             call s:FTm4("cfg")
	au! BufNewFile,BufRead *locale.conf.m4       call s:FTm4("cfg")
	au! BufNewFile,BufRead *.config.m4           call s:FTm4("conf")
	au! BufNewFile,BufRead *.fish.m4             call s:FTm4("fish")
	au! BufNewFile,BufRead *.json.m4             call s:FTm4("json")
	au! BufNewFile,BufRead *.lua.m4              call s:FTm4("lua")
	au! BufNewFile,BufRead {.,}tmux*.conf.m4     call s:FTm4("tmux")
	au! BufNewFile,BufRead *.vim.m4,*vimrc.m4    call s:FTm4("vim")
	au! BufNewFile,BufRead *.yaml.m4             call s:FTm4("yaml")
augroup END

func! s:FTm4(second_syntax)
	let b:second_syntax = a:second_syntax
	setf m4
endfunc
