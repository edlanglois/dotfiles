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
"   D=double-struck
if !exists("g:tex_conceal")
	let s:tex_conceal= 'abdmgsSD'
else
	let s:tex_conceal= g:tex_conceal
endif

if s:tex_fast =~ 'b'
	if s:tex_conceal =~ 'b'
		syn region texBoldStyle matchgroup=texTypeStyle start="\\bm\s*{" end="}" concealends contains=@texBoldGroup
	endif
endif

if has("conceal") && &enc == 'utf-8'
	" Double-struck
	if s:tex_conceal =~ 'D'
		fun! s:DoubleStrike(let,cchar)
			exe "syn match texDoubleStrike '\\\\mathbb\\s*{".a:let."}' conceal cchar=".a:cchar
		endfun
	
		call s:DoubleStrike('C','ℂ')
		call s:DoubleStrike('H','ℍ')
		call s:DoubleStrike('N','ℕ')
		call s:DoubleStrike('P','ℙ')
		call s:DoubleStrike('Q','ℚ')
		call s:DoubleStrike('R','ℝ')
		call s:DoubleStrike('Z','ℤ')
		delfun s:DoubleStrike
	endif
	
	" Math symbols
	if s:tex_conceal =~ 'm'
		let s:texMathList=[
			\ ['|'              , '‖'],
			\ ['aleph'          , 'ℵ'],
			\ ['amalg'          , '∐'],
			\ ['angle'          , '∠'],
			\ ['approx'         , '≈'],
			\ ['ast'            , '∗'],
			\ ['asymp'          , '≍'],
			\ ['backepsilon'    , '∍'],
			\ ['backsimeq'      , '≃'],
			\ ['backslash'      , '∖'],
			\ ['barwedge'       , '⊼'],
			\ ['because'        , '∵'],
			\ ['between'        , '≬'],
			\ ['bigcap'         , '∩'],
			\ ['bigcirc'        , '○'],
			\ ['bigcup'         , '∪'],
			\ ['bigodot'        , '⊙'],
			\ ['bigoplus'       , '⊕'],
			\ ['bigotimes'      , '⊗'],
			\ ['bigsqcup'       , '⊔'],
			\ ['bigtriangledown', '∇'],
			\ ['bigtriangleup'  , '∆'],
			\ ['bigvee'         , '⋁'],
			\ ['bigwedge'       , '⋀'],
			\ ['blacksquare'    , '∎'],
			\ ['bot'            , '⊥'],
			\ ['bowtie'         , '⋈'],
			\ ['boxdot'         , '⊡'],
			\ ['boxminus'       , '⊟'],
			\ ['boxplus'        , '⊞'],
			\ ['boxtimes'       , '⊠'],
			\ ['bullet'         , '•'],
			\ ['bumpeq'         , '≏'],
			\ ['Bumpeq'         , '≎'],
			\ ['cap'            , '∩'],
			\ ['Cap'            , '⋒'],
			\ ['cdot'           , '·'],
			\ ['cdots'          , '⋯'],
			\ ['circ'           , '∘'],
			\ ['circeq'         , '≗'],
			\ ['circlearrowleft', '↺'],
			\ ['circlearrowright', '↻'],
			\ ['circledast'     , '⊛'],
			\ ['circledcirc'    , '⊚'],
			\ ['clubsuit'       , '♣'],
			\ ['complement'     , '∁'],
			\ ['cong'           , '≅'],
			\ ['coprod'         , '∐'],
			\ ['copyright'      , '©'],
			\ ['cup'            , '∪'],
			\ ['Cup'            , '⋓'],
			\ ['curlyeqprec'    , '⋞'],
			\ ['curlyeqsucc'    , '⋟'],
			\ ['curlyvee'       , '⋎'],
			\ ['curlywedge'     , '⋏'],
			\ ['dagger'         , '†'],
			\ ['dashv'          , '⊣'],
			\ ['ddagger'        , '‡'],
			\ ['ddots'          , '⋱'],
			\ ['diamond'        , '⋄'],
			\ ['diamondsuit'    , '♢'],
			\ ['div'            , '÷'],
			\ ['doteq'          , '≐'],
			\ ['doteqdot'       , '≑'],
			\ ['dotplus'        , '∔'],
			\ ['dots'           , '…'],
			\ ['dotsb'          , '⋯'],
			\ ['dotsc'          , '…'],
			\ ['dotsi'          , '⋯'],
			\ ['dotso'          , '…'],
			\ ['doublebarwedge' , '⩞'],
			\ ['downarrow'      , '↓'],
			\ ['Downarrow'      , '⇓'],
			\ ['ell'            , 'ℓ'],
			\ ['emptyset'       , '∅'],
			\ ['eqcirc'         , '≖'],
			\ ['eqsim'          , '≂'],
			\ ['eqslantgtr'     , '⪖'],
			\ ['eqslantless'    , '⪕'],
			\ ['equiv'          , '≡'],
			\ ['exists'         , '∃'],
			\ ['fallingdotseq'  , '≒'],
			\ ['flat'           , '♭'],
			\ ['forall'         , '∀'],
			\ ['frown'          , '⁔'],
			\ ['ge'             , '≥'],
			\ ['geq'            , '≥'],
			\ ['geqq'           , '≧'],
			\ ['gets'           , '←'],
			\ ['gg'             , '⟫'],
			\ ['gneqq'          , '≩'],
			\ ['gtrdot'         , '⋗'],
			\ ['gtreqless'      , '⋛'],
			\ ['gtrless'        , '≷'],
			\ ['gtrsim'         , '≳'],
			\ ['hbar'           , 'ℏ'],
			\ ['heartsuit'      , '♡'],
			\ ['hookleftarrow'  , '↩'],
			\ ['hookrightarrow' , '↪'],
			\ ['iiint'          , '∭'],
			\ ['iint'           , '∬'],
			\ ['Im'             , 'ℑ'],
			\ ['imath'          , 'ɩ'],
			\ ['in'             , '∈'],
			\ ['infty'          , '∞'],
			\ ['int'            , '∫'],
			\ ['lceil'          , '⌈'],
			\ ['ldots'          , '…'],
			\ ['le'             , '≤'],
			\ ['leadsto'        , '↝'],
			\ ['left('          , '('],
			\ ['left\['         , '['],
			\ ['left\\{'        , '{'],
			\ ['leftarrow'      , '←'],
			\ ['Leftarrow'      , '⇐'],
			\ ['leftarrowtail'  , '↢'],
			\ ['leftharpoondown', '↽'],
			\ ['leftharpoonup'  , '↼'],
			\ ['leftrightarrow' , '↔'],
			\ ['Leftrightarrow' , '⇔'],
			\ ['leftrightsquigarrow', '↭'],
			\ ['leftthreetimes' , '⋋'],
			\ ['leq'            , '≤'],
			\ ['leq'            , '≤'],
			\ ['leqq'           , '≦'],
			\ ['lessdot'        , '⋖'],
			\ ['lesseqgtr'      , '⋚'],
			\ ['lesssim'        , '≲'],
			\ ['lfloor'         , '⌊'],
			\ ['ll'             , '≪'],
			\ ['lmoustache'     , '╭'],
			\ ['lneqq'          , '≨'],
			\ ['ltimes'         , '⋉'],
			\ ['mapsto'         , '↦'],
			\ ['measuredangle'  , '∡'],
			\ ['mid'            , '∣'],
			\ ['models'         , '╞'],
			\ ['mp'             , '∓'],
			\ ['nabla'          , '∇'],
			\ ['natural'        , '♮'],
			\ ['ncong'          , '≇'],
			\ ['ne'             , '≠'],
			\ ['nearrow'        , '↗'],
			\ ['neg'            , '¬'],
			\ ['neq'            , '≠'],
			\ ['nexists'        , '∄'],
			\ ['ngeq'           , '≱'],
			\ ['ngeqq'          , '≱'],
			\ ['ngtr'           , '≯'],
			\ ['ni'             , '∋'],
			\ ['nleftarrow'     , '↚'],
			\ ['nLeftarrow'     , '⇍'],
			\ ['nLeftrightarrow', '⇎'],
			\ ['nleq'           , '≰'],
			\ ['nleqq'          , '≰'],
			\ ['nless'          , '≮'],
			\ ['nmid'           , '∤'],
			\ ['notin'          , '∉'],
			\ ['nprec'          , '⊀'],
			\ ['nrightarrow'    , '↛'],
			\ ['nRightarrow'    , '⇏'],
			\ ['nsim'           , '≁'],
			\ ['nsucc'          , '⊁'],
			\ ['ntriangleleft'  , '⋪'],
			\ ['ntrianglelefteq', '⋬'],
			\ ['ntriangleright' , '⋫'],
			\ ['ntrianglerighteq', '⋭'],
			\ ['nvdash'         , '⊬'],
			\ ['nvDash'         , '⊭'],
			\ ['nVdash'         , '⊮'],
			\ ['nwarrow'        , '↖'],
			\ ['odot'           , '⊙'],
			\ ['oint'           , '∮'],
			\ ['ominus'         , '⊖'],
			\ ['oplus'          , '⊕'],
			\ ['oslash'         , '⊘'],
			\ ['otimes'         , '⊗'],
			\ ['owns'           , '∋'],
			\ ['P'              , '¶'],
			\ ['parallel'       , '║'],
			\ ['partial'        , '∂'],
			\ ['perp'           , '⊥'],
			\ ['pitchfork'      , '⋔'],
			\ ['pm'             , '±'],
			\ ['prec'           , '≺'],
			\ ['precapprox'     , '⪷'],
			\ ['preccurlyeq'    , '≼'],
			\ ['preceq'         , '⪯'],
			\ ['precnapprox'    , '⪹'],
			\ ['precneqq'       , '⪵'],
			\ ['precsim'        , '≾'],
			\ ['prime'          , '′'],
			\ ['prod'           , '∏'],
			\ ['propto'         , '∝'],
			\ ['rceil'          , '⌉'],
			\ ['Re'             , 'ℜ'],
			\ ['rfloor'         , '⌋'],
			\ ['right)'         , ')'],
			\ ['right]'         , ']'],
			\ ['right\\}'       , '}'],
			\ ['rightarrow'     , '→'],
			\ ['Rightarrow'     , '⇒'],
			\ ['rightarrowtail' , '↣'],
			\ ['rightleftharpoons', '⇌'],
			\ ['rightsquigarrow', '↝'],
			\ ['rightthreetimes', '⋌'],
			\ ['risingdotseq'   , '≓'],
			\ ['rmoustache'     , '╮'],
			\ ['rtimes'         , '⋊'],
			\ ['S'              , '§'],
			\ ['searrow'        , '↘'],
			\ ['setminus'       , '∖'],
			\ ['sharp'          , '♯'],
			\ ['sim'            , '∼'],
			\ ['simeq'          , '⋍'],
			\ ['smile'          , '‿'],
			\ ['spadesuit'      , '♠'],
			\ ['sphericalangle' , '∢'],
			\ ['sqcap'          , '⊓'],
			\ ['sqcup'          , '⊔'],
			\ ['sqrt'           , '√'],
			\ ['sqsubset'       , '⊏'],
			\ ['sqsubseteq'     , '⊑'],
			\ ['sqsupset'       , '⊐'],
			\ ['sqsupseteq'     , '⊒'],
			\ ['star'           , '✫'],
			\ ['subset'         , '⊂'],
			\ ['Subset'         , '⋐'],
			\ ['subseteq'       , '⊆'],
			\ ['subseteqq'      , '⫅'],
			\ ['subsetneq'      , '⊊'],
			\ ['subsetneqq'     , '⫋'],
			\ ['succ'           , '≻'],
			\ ['succapprox'     , '⪸'],
			\ ['succcurlyeq'    , '≽'],
			\ ['succeq'         , '⪰'],
			\ ['succnapprox'    , '⪺'],
			\ ['succneqq'       , '⪶'],
			\ ['succsim'        , '≿'],
			\ ['sum'            , '∑'],
			\ ['supset'         , '⊃'],
			\ ['Supset'         , '⋑'],
			\ ['supseteq'       , '⊇'],
			\ ['supseteqq'      , '⫆'],
			\ ['supsetneq'      , '⊋'],
			\ ['supsetneqq'     , '⫌'],
			\ ['surd'           , '√'],
			\ ['swarrow'        , '↙'],
			\ ['therefore'      , '∴'],
			\ ['times'          , '×'],
			\ ['to'             , '→'],
			\ ['top'            , '⊤'],
			\ ['triangle'       , '∆'],
			\ ['triangleleft'   , '⊲'],
			\ ['trianglelefteq' , '⊴'],
			\ ['triangleq'      , '≜'],
			\ ['triangleright'  , '⊳'],
			\ ['trianglerighteq', '⊵'],
			\ ['twoheadleftarrow', '↞'],
			\ ['twoheadrightarrow', '↠'],
			\ ['uparrow'        , '↑'],
			\ ['Uparrow'        , '⇑'],
			\ ['updownarrow'    , '↕'],
			\ ['Updownarrow'    , '⇕'],
			\ ['varnothing'     , '∅'],
			\ ['vartriangle'    , '∆'],
			\ ['vdash'          , '⊢'],
			\ ['vDash'          , '⊨'],
			\ ['Vdash'          , '⊩'],
			\ ['vdots'          , '⋮'],
			\ ['vee'            , '∨'],
			\ ['veebar'         , '⊻'],
			\ ['Vvdash'         , '⊪'],
			\ ['wedge'          , '∧'],
			\ ['wp'             , '℘'],
			\ ['wr'             , '≀']]
		for texmath in s:texMathList
			if texmath[0] =~ '\w$'
				exe "syn match texMathSymbol '\\\\".texmath[0]."\\>' contained conceal cchar=".texmath[1]
				exe "syn match texMathSymbol '\\\\".texmath[0]."\\d\\&\\\\".texmath[0]."' conceal cchar=".texmath[1]
			else
				exe "syn match texMathSymbol '\\\\".texmath[0]."' contained conceal cchar=".texmath[1]
			endif
		endfor
	endif
	
	" Clusters for concealing in math mode
	syn cluster texMathStyleGroup contains=texBoldStyle,texItalStyle,texBoldItalStyle
	syn cluster texMathZoneGroup add=@texMathStyleGroup,texDoubleStrike
	syn cluster texMathMatchGroup add=@texMathStyleGroup,texDoubleStrike
	
	" Superscripts/Subscripts {{{2
	" Custom version of default super/subscripts that only allows single characters.
	" Uses new 't' option in tex_conceal
	if s:tex_conceal =~ 't'
		fun! s:SuperSub(group,leader,pat,cchar)
				if a:pat =~ '^\\' || (a:leader == '\^' && a:pat =~ g:tex_superscripts) || (a:leader == '_' && a:pat =~ g:tex_subscripts)
	"     call echo("SuperSub: group<".a:group."> leader<".a:leader."> pat<".a:pat."> cchar<".a:cchar.">")
					exe 'syn match '.a:group." '".a:leader.a:pat."' contained conceal cchar=".a:cchar
				endif
		endfun
		call s:SuperSub('texSuperscript','\^','0','⁰')
		call s:SuperSub('texSuperscript','\^','1','¹')
		call s:SuperSub('texSuperscript','\^','2','²')
		call s:SuperSub('texSuperscript','\^','3','³')
		call s:SuperSub('texSuperscript','\^','4','⁴')
		call s:SuperSub('texSuperscript','\^','5','⁵')
		call s:SuperSub('texSuperscript','\^','6','⁶')
		call s:SuperSub('texSuperscript','\^','7','⁷')
		call s:SuperSub('texSuperscript','\^','8','⁸')
		call s:SuperSub('texSuperscript','\^','9','⁹')
		call s:SuperSub('texSuperscript','\^','a','ᵃ')
		call s:SuperSub('texSuperscript','\^','b','ᵇ')
		call s:SuperSub('texSuperscript','\^','c','ᶜ')
		call s:SuperSub('texSuperscript','\^','d','ᵈ')
		call s:SuperSub('texSuperscript','\^','e','ᵉ')
		call s:SuperSub('texSuperscript','\^','f','ᶠ')
		call s:SuperSub('texSuperscript','\^','g','ᵍ')
		call s:SuperSub('texSuperscript','\^','h','ʰ')
		call s:SuperSub('texSuperscript','\^','i','ⁱ')
		call s:SuperSub('texSuperscript','\^','j','ʲ')
		call s:SuperSub('texSuperscript','\^','k','ᵏ')
		call s:SuperSub('texSuperscript','\^','l','ˡ')
		call s:SuperSub('texSuperscript','\^','m','ᵐ')
		call s:SuperSub('texSuperscript','\^','n','ⁿ')
		call s:SuperSub('texSuperscript','\^','o','ᵒ')
		call s:SuperSub('texSuperscript','\^','p','ᵖ')
		call s:SuperSub('texSuperscript','\^','r','ʳ')
		call s:SuperSub('texSuperscript','\^','s','ˢ')
		call s:SuperSub('texSuperscript','\^','t','ᵗ')
		call s:SuperSub('texSuperscript','\^','u','ᵘ')
		call s:SuperSub('texSuperscript','\^','v','ᵛ')
		call s:SuperSub('texSuperscript','\^','w','ʷ')
		call s:SuperSub('texSuperscript','\^','x','ˣ')
		call s:SuperSub('texSuperscript','\^','y','ʸ')
		call s:SuperSub('texSuperscript','\^','z','ᶻ')
		call s:SuperSub('texSuperscript','\^','A','ᴬ')
		call s:SuperSub('texSuperscript','\^','B','ᴮ')
		call s:SuperSub('texSuperscript','\^','D','ᴰ')
		call s:SuperSub('texSuperscript','\^','E','ᴱ')
		call s:SuperSub('texSuperscript','\^','G','ᴳ')
		call s:SuperSub('texSuperscript','\^','H','ᴴ')
		call s:SuperSub('texSuperscript','\^','I','ᴵ')
		call s:SuperSub('texSuperscript','\^','J','ᴶ')
		call s:SuperSub('texSuperscript','\^','K','ᴷ')
		call s:SuperSub('texSuperscript','\^','L','ᴸ')
		call s:SuperSub('texSuperscript','\^','M','ᴹ')
		call s:SuperSub('texSuperscript','\^','N','ᴺ')
		call s:SuperSub('texSuperscript','\^','O','ᴼ')
		call s:SuperSub('texSuperscript','\^','P','ᴾ')
		call s:SuperSub('texSuperscript','\^','R','ᴿ')
		call s:SuperSub('texSuperscript','\^','T','ᵀ')
		call s:SuperSub('texSuperscript','\^','U','ᵁ')
		call s:SuperSub('texSuperscript','\^','W','ᵂ')
		call s:SuperSub('texSuperscript','\^',',','︐')
		call s:SuperSub('texSuperscript','\^',':','︓')
		call s:SuperSub('texSuperscript','\^',';','︔')
		call s:SuperSub('texSuperscript','\^','+','⁺')
		call s:SuperSub('texSuperscript','\^','-','⁻')
		call s:SuperSub('texSuperscript','\^','<','˂')
		call s:SuperSub('texSuperscript','\^','>','˃')
		call s:SuperSub('texSuperscript','\^','/','ˊ')
		call s:SuperSub('texSuperscript','\^','(','⁽')
		call s:SuperSub('texSuperscript','\^',')','⁾')
		call s:SuperSub('texSuperscript','\^','\.','˙')
		call s:SuperSub('texSuperscript','\^','=','˭')
		call s:SuperSub('texSubscript','_','0','₀')
		call s:SuperSub('texSubscript','_','1','₁')
		call s:SuperSub('texSubscript','_','2','₂')
		call s:SuperSub('texSubscript','_','3','₃')
		call s:SuperSub('texSubscript','_','4','₄')
		call s:SuperSub('texSubscript','_','5','₅')
		call s:SuperSub('texSubscript','_','6','₆')
		call s:SuperSub('texSubscript','_','7','₇')
		call s:SuperSub('texSubscript','_','8','₈')
		call s:SuperSub('texSubscript','_','9','₉')
		call s:SuperSub('texSubscript','_','a','ₐ')
		call s:SuperSub('texSubscript','_','e','ₑ')
		call s:SuperSub('texSubscript','_','i','ᵢ')
		call s:SuperSub('texSubscript','_','o','ₒ')
		call s:SuperSub('texSubscript','_','u','ᵤ')
		call s:SuperSub('texSubscript','_',',','︐')
		call s:SuperSub('texSubscript','_','+','₊')
		call s:SuperSub('texSubscript','_','-','₋')
		call s:SuperSub('texSubscript','_','/','ˏ')
		call s:SuperSub('texSubscript','_','(','₍')
		call s:SuperSub('texSubscript','_',')','₎')
		call s:SuperSub('texSubscript','_','\.','‸')
		call s:SuperSub('texSubscript','_','r','ᵣ')
		call s:SuperSub('texSubscript','_','v','ᵥ')
		call s:SuperSub('texSubscript','_','x','ₓ')
		call s:SuperSub('texSubscript','_','\\beta\>' ,'ᵦ')
		call s:SuperSub('texSubscript','_','\\delta\>','ᵨ')
		call s:SuperSub('texSubscript','_','\\phi\>'  ,'ᵩ')
		call s:SuperSub('texSubscript','_','\\gamma\>','ᵧ')
		call s:SuperSub('texSubscript','_','\\chi\>'  ,'ᵪ')
		delfun s:SuperSub
	endif
endif
