let b:ale_fixers = ['rustfmt']
let b:ale_linters = ['analyzer']
" TODO: Get the edition from Cargo.toml.
" Maybe ALE will support `cargo fmt` eventually.
" https://github.com/dense-analysis/ale/issues/3814
let g:ale_rust_rustfmt_options = '--edition 2021'
let g:ale_rust_analyzer_config = {
	\ 'checkOnSave': {'command': 'clippy', 'enable': v:true }
	\ }

" Only if using the linter 'cargo'
" let b:ale_rust_cargo_check_tests=1
" let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
