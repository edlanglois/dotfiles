" Avoid applying to fugitive buffers
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

" Don't mess with the indicator line; it is already relative to textwidth (+1)
let g:EditorConfig_max_line_indicator = 'none'
