$pdf_mode = 1;
$pdflatex = "pdflatex -interaction=nonstopmode %O %S";
$biber = "biber --validate-datamodel --dieondatamodel %O %S";

# Avoid wrapping log output lines
# See https://tex.stackexchange.com/a/384153 by John Collins
$ENV{max_print_line} = $log_wrap = 1000;

# Support glossaries
# See https://tex.stackexchange.com/a/44316 by user mhp
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
$clean_ext .= ' %R.ist %R.xdy';
