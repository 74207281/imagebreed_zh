
use strict;
use warnings;
use utf8;

use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/ page_title_html info_section_html /;

my $page = CXGN::Page->new("下載 SGN 軟體 (SGN software downloads)", "Lukas");

my $title = page_title_html("下載 SGN 軟體 (Download SGN software)");

$page->header("下載 (Downloads)", $title);

my $contents ="";

$contents .= info_section_html(title=>"SGN 比較檢視器 (SGN Comparative Viewer)", contents=><<CVIEW);

SGN 比較檢視器應用程式 (The SGN Comparative Viewer Application)。<br /><br />
下載 (Download) [<a href="ftp://ftp.sgn.cornell.edu/programs/cview/">FTP</a>]

CVIEW

$contents .= info_section_html(title=>"PerlCyc", contents=><<PERLCYC);

PerlCyc 是 <a href="http://bioinformatics.ai.sri.com/ptools/">Pathway Tools 軟體</a> 的 Perl 介面。它允許透過 Perl 存取 Pathway Tools 內部的 Lisp 函式。<a href="perlcyc.pl">更多資訊 (More...)...</a><br /><br />

    下載 (Download) [<a href="ftp://ftp.sgn.cornell.edu/programs/perlcyc/">FTP</a>]

PERLCYC


$contents .= info_section_html(title=>"JavaCyc", contents=><<JAVACYC);

JavaCyc 是 Pathway Tools 軟體的 Java 介面。它允許透過 Java 存取 Pathway Tools 內部的 Lisp 函式。<br /><br />

下載 (Download) [<a href="ftp://ftp.sgn.cornell.edu/programs/javacyc/">FTP</a>]

JAVACYC

    print $contents;

$page->footer();



