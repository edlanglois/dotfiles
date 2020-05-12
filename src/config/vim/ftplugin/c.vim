" Vim also executes this for c++ files
if (&ft != 'c')
	finish
endif
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
