use strict;
use utf8;

use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/info_section_html info_table_html/;

my $page=CXGN::Page->new('Tomato Unigene Build 2 Notes','Lukas');
$page->header('番茄 Unigene 建構版本發布說明 (Tomato Unigene Build Release Notes)', '關於番茄 Unigene 建構版本 2 (About the Tomato Unigene Build 2)');

print<<END_HEREDOC;

<div class="indentedcontent">

2008 年 5 月 (May 2008)<br /><br />
全新番茄 unigene 建構版本由以下資料組裝而成：(A new unigene build for tomato has been assembled from the following data:)
<ul>
    <li>323,277 條來自番茄物種的 EST (ESTs from tomato species)
    <ul>
      <li><i>Solanum lycopersicum</i> 共 307,350 條序列</li>
      <li><i>Solanum habrochaites</i> 共 8,255 條序列</li>
      <li><i>Solanum pennellii</i> 共 7,812 條序列</li>
      <li><i>Solanum pimpinellifolium</i> 共 8 條序列</li>
      <li><i>Solanum peruvianum</i> 共 42 條序列</li>
      <li><i>Solanum cheesmaniae</i> 共 4 條序列</li>
      <li><i>Solanum lycopersicoides</i> 共 2 條序列</li>
    </ul>
    </li>

    <li>新增 EST 序列獲取自：(New EST sequences were obtained from:)
      <ul>
        <li>GenBank 資料庫（核苷酸之 dbEST 和 mRNA）(GenBank database: dbEST and mRNA)</li>
      </ul>
    </li>

    <li>新版本包含 42,257 個 unigene，其中 24,020 個為重疊群 (contigs)，18,237 個為單一序列 (singletons)。(The new build contains 42,257 unigenes, of which 24,020 are contigs and 18,237 are singletons.)</li>

    <li>對 unigene 執行的分析：(Analyses performed on the unigenes:)
    <ul>
      <li>ESTScan 與 Longest6frame.pl - 預測多肽（分別預測了 39,967 與 43,366 條多肽）(to predict peptides)</li>
      <li>InterproScan 應用於多肽 - 預測蛋白質結構域並關聯基因本體代碼（分別從兩種多肽預測方法的多肽資料集中關聯了 6,626 與 1,482 個不同結構域）(to predict protein domains and associate Gene Ontology codes)</li>
      <li>BLAST 比對 Genbank NR、Arabidopsis 及 Swissprot 資料庫（分別有 30,791、28,656 與 19,886 個 unigene 與這些蛋白質資料集比對成功）(BLAST against Genbank NR, Arabidopsis and Swissprot)</li>
    </ul>
    </li>
    <li>此版本的 unigene ID 範圍為：SGN-U562593 至 SGN-U604849。(The range of unigene ids for this build is: SGN-U562593 through SGN-U604849.)</li>
    </ul>

在 SGN 中訪問新番茄物種 unigene 建構版本的不同方式：(Different ways to access the new tomato species unigene build in SGN:)
<ul>
<li>使用 <a href="http://sgn.cornell.edu/tools/blast/">SGN Blast</a> 進行序列同源性搜尋。(Sequence homology search using SGN Blast.)</li>
<li>使用 SGN <a href="http://sgn.cornell.edu/bulk/input.pl?mode=unigene">批次下載工具 (Bulk download tool)</a> 批次下載 unigene 登錄號（或登錄號列表）。(Bulk download for a unigene accession or list of accessions.)</li>
<li>從 <a href="ftp://ftp.sgn.cornell.edu/unigene_builds">SGN FTP 站點 (SGN FTP site)</a> 完整下載所有 unigene 序列和註解。(Complete download of all unigene sequences and annotations.)</li> 
</ul>
</div>

END_HEREDOC

$page->footer();
