use strict;
use utf8;
use warnings;

use CXGN::Page;
use CatalystX::GlobalContext '$c';
use File::Slurp qw/slurp/;

my $documents_folder = $c->get_conf('basepath') . $c->get_conf('documents_subdir');
my $page = CXGN::Page->new('精選 SOL 社群實驗室 (Featured SOL Community Labs)','john');
my $LABS = slurp("$documents_folder/labs.txt")||'';
$page->header('精選 SOL 社群實驗室 (Featured SOL Community Labs)');
print $LABS;
$page->footer();
