call TexNewMathZone("M", "dmath", 1)

syn sync maxlines=200
syn sync minlines=20

syn region texBoldStyle matchgroup=texTypeStyle start="\\bm\s*{" end="}" concealends contains=@texBoldGroup
syn cluster texMathStyleGroup contains=texBoldStyle,texItalStyle,texBoldItalStyle
syn cluster texMathZoneGroup add=@texMathStyleGroup
syn cluster texMathMatchGroup add=@texMathStyleGroup
