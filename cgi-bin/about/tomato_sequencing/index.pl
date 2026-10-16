use strict;
use utf8;
use CXGN::Page;
use CXGN::Page::Toolbar::SGN;
my $page=CXGN::Page->new("定序 (Sequencing)","john");
$page->header();
my $tb=CXGN::Page::Toolbar::SGN->new();
print $tb->index_page('sequencing');
$page->footer();
