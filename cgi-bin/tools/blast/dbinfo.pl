use strict;
use CatalystX::GlobalContext qw( $c );

$c->forward_to_mason_view('/tools/blast/dbinfo.mas');
