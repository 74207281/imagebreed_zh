use strict;
use utf8;

use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/info_section_html info_table_html/;

my $page=CXGN::Page->new('Tomato Unigene Build 1 Notes','Lukas');
$page->header('番茄 Unigene 建構版本發布說明 (Tomato Unigene Build Release Notes)', '關於番茄 Unigene 建構版本 1 (About the Tomato Unigene Build 1)');

print<<END_HEREDOC;

<div class="indentedcontent">

2006 年 9 月 (September 2006)<br /><br />
全新番茄 unigene 建構版本由以下資料組裝而成：(A new unigene build for tomato has been assembled from the following data:)
<ul>
    <li>235,836 條來自番茄物種的 EST (ESTs from tomato species)
    <ul>
      <li><i>Solanum lycopersicum</i></li>
      <li><i>Solanum habrochaites</i></li>
      <li><i>Solanum pennellii</i></li>
      <li><i>Microtom.</i></li>
    </ul>
    我們還納入了來自 Genbank 的 3,336 條 mRNA 序列，涵蓋以下番茄物種：(We also included 3336 mRNA sequences from Genbank for the following tomato species:)
    <ul>
      <li><i>Solanum lycopersicum</i></li>
      <li><i>Solanum habrochaites</i></li>
      <li><i>Solanum pennellii</i></li>
      <li><i>Solanum pimpinellifolium</i></li>
      <li><i>Solanum peruvianum</i></li>
      <li><i>Solanum cheesmaniae</i></li>
      <li><i>Solanum habrochaites</i></li>
      <li><i>Solanum lycopersicoides</i></li>
    </ul>
    </li>

    <li>新增 EST 序列獲取自：(New EST sequences were obtained from:)
      <ul>
        <li>Prof Shibata, Kazusa Institute.</li>
        <li>Dr. Eyal Fridman, University of Michigan</li>
      </ul>
    </li>

    <li>新版本包含 34,829 個 unigene，其中 21,153 個為重疊群 (contigs)，13,676 個為單一序列 (singletons)。(The new build contains 34,829 unigenes, of which 21,153 are contigs and 13,676 are singletons.)</li>

    <li>對 unigene 執行的分析：(Analyses performed on the unigenes:)
    <ul>
      <li>ESTScan - 預測多肽 (to predict peptides)</li>
      <li>InterproScan 應用於多肽 - 預測蛋白質結構域並關聯基因本體代碼 (to predict protein domains and associate Gene Ontology codes)</li>
      <li>BLAST 比對擬南芥和 Genbank NR 資料庫 (BLAST against Arabidopsis and Genbank NR)</li>
    </ul>
    </li>
    <li>此版本的 unigene ID 範圍為：312296 至 347124。(The range of unigene ids for this build is: 312296 through 347124.)</li>
    </ul>
SGN 連結 (SGN Links):
<ul>
<li><a href="http://sgn-devel.sgn.cornell.edu/search/direct_search.pl?search=unigene">SGN Unigene 搜尋 (SGN Unigene Search)</a></li>
<li><a href="ftp://ftp.sgn.cornell.edu/unigene_builds">SGN FTP 伺服器 (SGN FTP server)</a></li>
</ul>

外部連結 (External Links):
<ul>
<li><a href="http://www.kazusa.or.jp/jsol/microtom/index.html" class="external">日本上總 Micro-Tom 資料庫 (Micro-Tom Database Kazusa, Japan)</a></li>
</ul>
</div>

END_HEREDOC

$page->footer();
