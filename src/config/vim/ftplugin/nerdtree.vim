" Ensure the Bookmarks directory exists
echom 'Opened NERDTree'
if exists('NERDTreeBookmarksFile')
	call mkdir(fnamemodify(NERDTreeBookmarksFile,':p:h'), 'p')
endif
