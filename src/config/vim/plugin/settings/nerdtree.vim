let NERDTreeIgnore = [
	\'\.pyc$',
	\'\.egg-info',
	\'__pycache__',
	\]

" Don't update the NERDTree git flags (nerdtree-git-plugin) on write.
" The update interferes with python-mode's lint-on-write.
let NERDTreeUpdateOnWrite=0
" Use XDG directories for bookmarks
let NERDTreeBookmarksFile=g:xdg_data_home . '/vim/plugins/nerdtree/bookmarks'
