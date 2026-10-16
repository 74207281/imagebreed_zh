use strict;
use utf8;
use CatalystX::GlobalContext qw( $c );

$c->forward_to_mason_view('/help/fish_submission.mas');

