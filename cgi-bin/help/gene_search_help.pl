use strict;
use CatalystX::GlobalContext qw( $c );

$c->forward_to_mason_view('/help/gene_search_help.mas');
