" Custom filetype mappings
if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	" au! commands to set the filetype go here
	au! BufNewFile,BufRead .latexmkrc,latexmkrc  setf perl

	" M4 Files
	au! BufNewFile,BufRead *.sh.m4,bashrc.m4     call s:FTm4("bash")
	au! BufNewFile,BufRead *.hgrc.m4,hgrc.m4     call s:FTm4("cfg")
	au! BufNewFile,BufRead *locale.conf.m4       call s:FTm4("cfg")
	" No single answer for config files but cfg tends to work most of the time
	au! BufNewFile,BufRead *.config.m4,config.m4 call s:FTm4("cfg")
	au! BufNewFile,BufRead matplotlibrc.m4       call s:FTm4("conf")
	au! BufNewFile,BufRead pam_env.conf.m4       call s:FTm4("conf")
	au! BufNewFile,BufRead *.ini.m4              call s:FTm4("dosini")
	au! BufNewFile,BufRead *.fish.m4             call s:FTm4("fish")
	au! BufNewFile,BufRead *.json.m4             call s:FTm4("json")
	au! BufNewFile,BufRead *.lua.m4              call s:FTm4("lua")
	au! BufNewFile,BufRead latexmkrc.m4          call s:FTm4("perl")
	au! BufNewFile,BufRead profile.m4,xinitrc.m4,xserverrc.m4  call s:FTm4("sh")
	au! BufNewFile,BufRead *.service.m4,*.timer.m4  call s:FTm4("systemd")
	au! BufNewFile,BufRead {.,}tmux*.conf.m4     call s:FTm4("tmux")
	au! BufNewFile,BufRead *.vim.m4,*vimrc.m4    call s:FTm4("vim")
	au! BufNewFile,BufRead Xresources.m4         call s:FTm4("xdefaults")
	au! BufNewFile,BufRead Xmodmap.m4            call s:FTm4("xmodmap")
	au! BufNewFile,BufRead *.yaml.m4             call s:FTm4("yaml")
augroup END

func! s:FTm4(second_syntax)
	let b:second_syntax = a:second_syntax
	setf m4
endfunc
