use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('microsats.html','html2pl converter');
$page->header('微衛星 (SSR) 標記 (Microsatellites / SSRs)');
print<<END_HEREDOC;

  <center>
    
    <br />

    <h3 align="center">微衛星 (SSR) 標記 (Microsatellites / SSRs)</h3>

    <p>雖然微衛星或簡單重複序列 (SSR) 通常出現在基因組的非編碼區，但它們也可能出現在 EST 的 3' 或 5' UTR，甚至是編碼區（通常為三核苷酸重複）。因此，SGN 於 2001 年 5 月使用由密蘇里州聖路易斯 Genomics Edge Technologies, Inc. 開發的分析工具，對 SGN 中收錄的番茄與馬鈴薯 EST 序列進行了微衛星序列基序篩選。其目的是鑑定可用於番茄遺傳學與育種研究的多型性分子標記 SSR。檢索參數涵蓋 2 bp 至 6 bp 的所有可能重複基序，重複區塊 &gt; 20 bp。搜尋演算法允許不完全重複以及複合重複。</p>

    <p>對於希望測試 SSR 以進行圖譜定位/多型性研究的使用者，建議（根據實驗經驗）從以下條件開始：<br /></p>

    <ul>
      <li>二核苷酸重複數 &gt; 12 (dinucleotides &gt; 12 repeats)</li>

      <li>三核苷酸重複數 &gt; 8 (trinucleotide &gt; 8 repeats)</li>

      <li>四至六核苷酸重複數 &gt; 6 (tetra to hexanucleotides &gt; 6 repeats)</li>
    </ul>
    <p>
    <a href="/search/markers/markersearch.pl?searchtype=startswith&amp;name=&amp;submit=search&amp;mapped=on&amp;confidence=0&amp;offsetstart=&amp;offsetend=&amp;chromosomes=all&amp;species=all&amp;maps=all&amp;types=SSR&amp;techniques=all">在分子標記搜尋結果中檢視所有 SSR 標記 (See all SSR markers in marker search results)</a><br />
    <a href="/documents/markers/microsat_list.txt">舊版純文字格式 SSR 列表 (Old text version SSR list)</a>
    </p>
    
  </center>
END_HEREDOC
$page->footer();
