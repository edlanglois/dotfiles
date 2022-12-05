m4_include(user_config.m4)m4_dnl
m4_include(env_config.m4)m4_dnl

" Enable ALE integration
let g:airline#extensions#ale#enabled = 1

m4_ifdef({<<m4_env_config_NETUSER>>},m4_dnl
" Disable version control integration (slow when filesystem is slow)
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#fugitiveline#enabled = 0
)m4_dnl

" Check trailing whitespace with airline (but not mixed tabs/spaces)
let g:airline#extensions#whitespace#checks = ['trailing']

" Set the airline theme
let g:airline_theme = 'wombat'

m4_ifelse(m4_user_config_POWERLINE_SYMBOLS,true,{<<
" Use non-standard symbols for a better-looking airline.
" Requires installing the powerline fonts:
" https://powerline.readthedocs.org/en/master/installation.html#patched-fonts
let g:airline_powerline_fonts = 1
>>},{<<
" Use standard symbols. Don't have to install special font.
let g:airline_powerline_fonts = 0
>>})m4_dnl
