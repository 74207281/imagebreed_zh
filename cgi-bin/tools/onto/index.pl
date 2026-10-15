use strict;
use warnings;
use utf8;

use CXGN::Page;

use CXGN::Page::FormattingHelpers qw/ info_section_html /;
use CatalystX::GlobalContext qw( $c );
my $p = CXGN::Page->new("本體論瀏覽器 (Ontology Browser)", "Lukas");
$p->header("本體論瀏覽器 (Ontology Browser)", "瀏覽本體論 (Browse Ontologies)");

print info_section_html(
    title    => '本體論瀏覽器 (Ontology Browser)',
    contents => $c->render_mason("/ontology/browser.mas"),
   );

$p->footer();

