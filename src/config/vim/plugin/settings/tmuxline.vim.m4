m4_include(user_config.m4)m4_dnl

m4_ifelse(m4_user_config_POWERLINE_SYMBOLS,true,
" Use non-standard symbols for a better-looking airline.
" Requires installing the powerline fonts:
" https://powerline.readthedocs.org/en/master/installation.html#patched-fonts
let g:tmuxline_powerline_separators = 1,
" Use standard symbols. Don't have to install special font.
let g:tmuxline_powerline_separators = 0
)

" Tmuxline based on the 'powerline' preset but with 12 hour time.
let g:tmuxline_preset = {
	\'a'    : '#S',
	\'b'    : '#F',
	\'win'  : ['#I', '#W'],
	\'cwin' : ['#I', '#W'],
	\'y'    : ['%Y-%m-%d', '%I:%M %p'],
	\'z'    : '#h',
	\'options' : {'status-justify' : 'left'},
\}
