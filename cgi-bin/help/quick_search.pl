use strict;
use CatalystX::GlobalContext qw( $c );

$c->forward_to_mason_view('/help/quick_search.mas');