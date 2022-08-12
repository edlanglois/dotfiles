let b:ale_fixers = ['rustfmt']
let b:ale_linters = ['analyzer']
" TODO: Get the edition from Cargo.toml.
" Maybe ALE will support `cargo fmt` eventually.
" https://github.com/dense-analysis/ale/issues/3814
let g:ale_rust_rustfmt_options = '--edition 2021'
" TODO: Remove the useRustcWrapper config once rust-analyzer is fixed
" https://github.com/rust-lang/rust-analyzer/issues/12973
let g:ale_rust_analyzer_config = {
	\ 'cargo': {'buildScripts': {'useRustcWrapper': v:false }},
	\ 'checkOnSave': {'command': 'clippy', 'enable': v:true },
	\ }

" Only if using the linter 'cargo'
" let b:ale_rust_cargo_check_tests=1
" let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
