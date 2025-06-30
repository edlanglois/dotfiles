" Ensure the Bookmarks directory exists
if exists('NERDTreeBookmarksFile')
	call mkdir(fnamemodify(NERDTreeBookmarksFile,':p:h'), 'p')
endif
