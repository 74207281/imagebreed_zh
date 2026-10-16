use strict;
use CatalystX::GlobalContext qw( $c );

$c->forward_to_mason_view('/help/phenotype_search_help.mas');
