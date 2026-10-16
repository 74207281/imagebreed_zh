use strict;
use CatalystX::GlobalContext qw( $c );

$c->forward_to_mason_view(
    '/help/publications.mas',
    basepath         => $c->config->{basepath},
    documents_subdir => $c->config->{documents_subdir},
);
