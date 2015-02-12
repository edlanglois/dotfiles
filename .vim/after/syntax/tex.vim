call TexNewMathZone("M", "dmath", 1)

syn sync maxlines=200
syn sync minlines=20

" Set tex_fast and tex_conceal to global values or defaults
" by default, enable all region-based highlighting
let s:tex_fast= "bcmMprsSvV"
if exists("g:tex_fast")
 if type(g:tex_fast) != 1
  " g:tex_fast exists and is not a string, so
  " turn off all optional region-based highighting
  let s:tex_fast= ""
 else
  let s:tex_fast= g:tex_fast
 endif
else
 let s:tex_fast= "bcmMprsSvV"
endif
" let user determine which classes of concealment will be supported
"   a=accents/ligatures d=delimiters m=math symbols  g=Greek  s=superscripts/subscripts
if !exists("g:tex_conceal")
 let s:tex_conceal= 'abdmgsS'
else
 let s:tex_conceal= g:tex_conceal
endif

if s:tex_fast =~ 'b'
	if s:tex_conceal =~ 'b'
		syn region texBoldStyle matchgroup=texTypeStyle start="\\bm\s*{" end="}" concealends contains=@texBoldGroup
	endif
endif

syn cluster texMathStyleGroup contains=texBoldStyle,texItalStyle,texBoldItalStyle
if has("conceal") && &enc == 'utf-8'
	syn cluster texMathZoneGroup add=@texMathStyleGroup
	syn cluster texMathMatchGroup add=@texMathStyleGroup
endif
