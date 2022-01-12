let b:ale_fixers = ['rustfmt']
let b:ale_linters = ['analyzer']
let g:ale_rust_analyzer_config = {
	\ 'checkOnSave': {'command': 'clippy', 'enable': v:true }
	\ }

" Only if using the linter 'cargo'
" let b:ale_rust_cargo_check_tests=1
" let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
