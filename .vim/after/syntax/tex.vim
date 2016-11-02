" Parts of this file are copied from the syntax/tex.vim script that is
" distributed with VIM (and written by Dr. Charles E. Campbell, Jr)
"
" As such, the following license applies:
" VIM LICENSE
"
" I)  There are no restrictions on distributing unmodified copies of Vim except
"     that they must include this license text.  You can also distribute
"     unmodified parts of Vim, likewise unrestricted except that they must
"     include this license text.  You are also allowed to include executables
"     that you made from the unmodified Vim sources, plus your own usage
"     examples and Vim scripts.
"
" II) It is allowed to distribute a modified (or extended) version of Vim,
"     including executables and/or source code, when the following four
"     conditions are met:
"     1) This license text must be included unmodified.
"     2) The modified Vim must be distributed in one of the following five ways:
"        a) If you make changes to Vim yourself, you must clearly describe in
"     the distribution how to contact you.  When the maintainer asks you
"     (in any way) for a copy of the modified Vim you distributed, you
"     must make your changes, including source code, available to the
"     maintainer without fee.  The maintainer reserves the right to
"     include your changes in the official version of Vim.  What the
"     maintainer will do with your changes and under what license they
"     will be distributed is negotiable.  If there has been no negotiation
"     then this license, or a later version, also applies to your changes.
"   The current maintainer is Bram Moolenaar <Bram@vim.org>. If this 
"     changes it will be announced in appropriate places (most likely
"     vim.sf.net, www.vim.org and/or comp.editors).  When it is completely
"     impossible to contact the maintainer, the obligation to send him
"     your changes ceases.  Once the maintainer has confirmed that he has
"     received your changes they will not have to be sent again.
"        b) If you have received a modified Vim that was distributed as
"     mentioned under a) you are allowed to further distribute it
"     unmodified, as mentioned at I).  If you make additional changes the
"     text under a) applies to those changes.
"        c) Provide all the changes, including source code, with every copy of
"     the modified Vim you distribute.  This may be done in the form of a
"     context diff.  You can choose what license to use for new code you
"     add.  The changes and their license must not restrict others from
"     making their own changes to the official version of Vim.
"        d) When you have a modified Vim which includes changes as mentioned
"     under c), you can distribute it without the source code for the
"     changes if the following three conditions are met:
"     - The license that applies to the changes permits you to distribute
"       the changes to the Vim maintainer without fee or restriction, and
"       permits the Vim maintainer to include the changes in the official
"       version of Vim without fee or restriction.
"     - You keep the changes for at least three years after last
"       distributing the corresponding modified Vim.  When the maintainer
"       or someone who you distributed the modified Vim to asks you (in
"       any way) for the changes within this period, you must make them
"       available to him.
"     - You clearly describe in the distribution how to contact you.  This
"       contact information must remain valid for at least three years
"       after last distributing the corresponding modified Vim, or as long
"       as possible.
"        e) When the GNU General Public License (GPL) applies to the changes,
"     you can distribute the modified Vim under the GNU GPL version 2 or
"     any later version.
"     3) A message must be added, at least in the output of the ":version"
"        command and in the intro screen, such that the user of the modified Vim
"        is able to see that it was modified.  When distributing as mentioned
"        under 2)e) adding the message is only required for as far as this does
"        not conflict with the license used for the changes.
"     4) The contact information as required under 2)a) and 2)d) must not be
"        removed or changed, except that the person himself can make
"        corrections.
"
" III) If you distribute a modified version of Vim, you are encouraged to use
"      the Vim license for your changes and make them available to the
"      maintainer, including the source code.  The preferred way to do this is
"      by e-mail or by uploading the files to a server and e-mailing the URL.
"      If the number of changes is small (e.g., a modified Makefile) e-mailing a
"      context diff will do.  The e-mail address to be used is
" <maintainer@vim.org>
"
" IV)  It is not allowed to remove this license from the distribution of the Vim
"      sources, parts of it or from a modified version.  You may use this
"      license for previous Vim releases instead of the license that they came
"      with, at your option.

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

	if !exists("g:tex_superscripts")
		let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
	endif
	if !exists("g:tex_subscripts")
	  let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
	endif

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
