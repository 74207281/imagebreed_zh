#!/usr/bin/perl

use strict;
use warnings;
use utf8;

use CXGN::Page;
use File::Spec;
use CXGN::DB::Connection;
use CXGN::BlastWatch;

use CGI ();

use CatalystX::GlobalContext qw( $c );

my $page = CXGN::Page->new( "BLAST watch results", "Adri");

my $cgi = CGI->new;

my $bw_query_id = $cgi->param('query');

my $dbh = CXGN::DB::Connection->new();

$c->throw( message => "未選擇任何查詢。(No query chosen.)", is_error => 0 ) unless $bw_query_id;

my $select = "SELECT sequence, program, database, matrix, evalue, num_results "
    . "FROM blastwatch_queries where blastwatch_queries_id = ?";
my $sth = $dbh->prepare($select);
$sth->execute($bw_query_id);
my (@v) = $sth->fetchrow();
$sth->finish;

my $results = CXGN::BlastWatch::get_results($dbh,$bw_query_id);

if (!$results) { &user_error($page, "無效的查詢。(Invalid query.)") }

website($page, $results,@v);

#---------------#

sub website {
    my ($page, $results,$sequence,$program,$database,$matrix,$evalue,$num_results) = @_;

    # force sequence to wrap                                                                                                                         
    
    my $length = length($sequence);
    my $wrap = 85;
    for (my $i = $wrap; $i < $length ; $i += $wrap + 1) {
	substr($sequence, $i, 0) = " ";
    }
    
    $page->header('BLAST 監控結果 (BLAST Watch Results)','BLAST 監控結果 (BLAST Watch Results)');
    
    print <<EOF;

<p><strong>查詢序列 (Query sequence):</strong><br/>
$sequence</p>

<p><strong>程式 (Program):</strong> $program</p>

<p><strong>資料庫 (Database):</strong> $database</p>

<p><strong>替代矩陣 (Substitution Matrix):</strong> $matrix</p>

<p><strong>預期值門檻 (Expect / e-value Threshold):</strong> $evalue</p>

<strong>比對結果 (Results):</strong>

EOF

if ($results ne "No results found.") {
    print <<TEXT;
    
    <table summary="" width="90%">
	<tr>
	<td><strong>查詢 (Query)</strong></td>
	<td><strong>比對目標 (Hit)</strong></td>
	<td><strong>起始 (Start)</strong></td>
	<td><strong>結束 (End)</strong></td>
	<td><strong>預期值 (E-value)</strong></td>
	<td><strong>分數 (Score)</strong></td>
	<td></td>
	</tr>
	$results
	</table>
	
TEXT
}

    else { print "<p>未找到任何比對結果。(No results found.)</p>"; }

    $page->footer();
    
}

sub user_error {
    my ($page,$reason) = @_;
    
    $page->header();
    
    print <<EOF;
    <h4>SGN BLAST 監控錯誤 (SGN BLAST Watch Error)</h4>
	<p>$reason</p>
EOF

    $page->footer();
    exit(0);
}
