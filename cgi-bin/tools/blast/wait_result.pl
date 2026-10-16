#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;
use CXGN::Page;
use CatalystX::GlobalContext '$c';

my $tmpdir = $c->config->{'basepath'} . $c->config->{'tempfiles_subdir'} . "/blastgraph/";

our $page = CXGN::Page->new("BLAST 執行中 (BLAST running)", "Koni");

#'output_graphs' will be passed on to view_result.pl
my ($request_file, $not_finished, $invalid, $output_graph_option) 
	= $page->get_arguments("request", "notfinished","invalids", "output_graphs");

if ( ! -f "$tmpdir/${request_file}.req" ) {
  print STDERR "$request_file ($!)\n";
  request_not_found($page);
}

open REQUEST_FILE, "<$tmpdir/$request_file.req"
  or $page->error_page("Failed to open BLAST request file " . "\"$request_file\" ($!)");

my @output = ();
my $refresh = "";
while(<REQUEST_FILE>) {
  chomp;
  my ($name, $file) = split/\t/;

  if ( -f "$tmpdir/$file.html" ) {
    push @output, "<tr><td><a href=\"./view_result.pl?result_file=$file.html&output_graphs=$output_graph_option\">$name</a></td><td><font color=#009900>已完成 (Finished)</font></td></tr>";
  } elsif ( -f "$tmpdir/$file" ) {
    push @output, "<tr><td>$name</td><td><font color=\"#CCCC00\">執行中 (Running)</font></td></tr>";
    $refresh = "<meta http-equiv=\"Refresh\" content=\"30; URL=./wait_result.pl?request=$request_file&invalids=$invalid&output_graphs=$output_graph_option\">";
    $not_finished="yes";
  } else {
    push @output, "<tr><td>$name</td><td><font color=#CC0000>排隊中 (Queued)</font></td></tr>";
    $refresh = "<meta http-equiv=\"Refresh\" content=\"30; URL=./wait_result.pl?request=$request_file&invalids=$invalid&output_graphs=$output_graph_option\">";
    $not_finished="yes";
  }
}

close REQUEST_FILE;

my $text = "";
if ($not_finished eq "yes") {

  $text = "<tr><td><p>您的 BLAST 請求仍在執行中。請使用下方連結檢視結果。重新整理此頁面以更新狀態。此頁面將每 <b>30 秒</b> 自動重新整理一次 (Your BLAST request is still running. This page will automatically reload every 30 seconds)。</p></td></tr>";
} else {
  $text = "<tr><td align=\"center\"><p>BLAST 已完成。請使用下方連結檢視結果 (BLAST finished. Use links below to view results)。</p></td></tr>";
}

my $invalid_text;
if ($invalid eq "yes") {
  $invalid_text ="<p>注意：某些 BLAST 程式與目標資料庫的組合無效（例如在核苷酸資料庫上進行蛋白質搜尋），已自動略過 (NOTE: Some combinations of BLAST programs and target databases were invalid and automatically skipped)。</p>";
} else {
  $invalid_text = "";
}

$page->header("", $refresh);

print <<EOF;

<h4><center>SGN BLAST 搜尋結果 (SGN BLAST SEARCH RESULTS)</center></h4>

<table width="80%" cellpadding="2" cellspacing="2" border="0" align="center">
$text
<tr><td><table cellpadding="2" cellspacing="2" border="0" align="center">
  <tr><th>工作 (Job)</th><th>狀態 (Status)</th></tr>
  <tr><td></td><td><img src="/documents/img/dot_clear.png" height="1" width="40"></td></tr>
  @output
  </table>
  $invalid_text
</td></tr>
</table>
<br />
EOF



$page->footer();

sub request_not_found {
  my ($page) = @_;

  $page->header();

  print <<EOF;

  <h4>SGN BLAST 錯誤 -- 找不到舊請求 (SGN BLAST ERROR -- OLD REQUEST NOT FOUND)</h4>

  <p>您的瀏覽器請求了不存在的 BLAST 工作狀態。請<b>不要將 BLAST 結果加入書籤</b>，它們會在 2 天後自伺服器自動刪除 (Your browser requested the status of a BLAST job which does not exist. BLAST results are automatically deleted after 2 days)。</p>

EOF

  $page->footer();
  exit(0);
}

