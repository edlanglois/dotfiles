m4_include(env_config.m4)m4_dnl
let b:ale_fixers = ['rustfmt']
let b:ale_linters = ['analyzer']
" TODO: Get the edition from Cargo.toml.
" Maybe ALE will support `cargo fmt` eventually.
" https://github.com/dense-analysis/ale/issues/3814
let g:ale_rust_rustfmt_options = '--edition 2021'
let g:ale_rust_analyzer_config = {
	\ 'checkOnSave': {'command': 'clippy', 'enable': v:true },
	\ }

m4_dnl Uncomment this to debug rust analyzer.
m4_dnl let g:ale_rust_analyzer_executable =
m4_dnl 	\ "m4_env_config_XDG_DATA_HOME/rust-analyzer-debug/rust-analyzer-debug"

" Only if using the linter 'cargo'
" let b:ale_rust_cargo_check_tests=1
" let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
