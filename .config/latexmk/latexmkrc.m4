$pdf_mode = 1;
$pdflatex = "pdflatex -interaction=nonstopmode %O %S";
$biber = "biber --validate-datamodel --dieondatamodel %O %S";
# Force deletion of .bbl even if no .bib exists
$bibtex_use = 2;
# Created by biber; not cleaned by default (don't know why)
$clean_ext .= ' %R.run.xml';

# Avoid wrapping log output lines
# See https://tex.stackexchange.com/a/384153 by John Collins
$ENV{max_print_line} = $log_wrap = 1000;

# Support glossaries
# See https://tex.stackexchange.com/a/44316 by user mhp
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
sub run_makeglossaries {
  my @gls_args = ();
  if ( $silent ) {
    push @gls_args, "-q";
  }
  # makeglossaries fails when running outside the target directory
  # move to the target directory before running
  my ($basename, $path) = fileparse( $_[0] );
  pushd $path;
  my $gls_command = join " ", "makeglossaries", @gls_args, "'$basename'";
  my $return = system "$gls_command";
  popd;
  return $return;
}

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
$clean_ext .= ' %R.ist %R.xdy';
