use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('mutants_main.html','html2pl converter');
$page->header('突變株 (Mutants)');
print<<END_HEREDOC;


<table summary="" width="720" cellpadding="0" cellspacing="0"
border="0">
<tr>
<td>
<ul>
<li><a href="http://zamir.sgn.cornell.edu/mutants/">建構番茄的基因 (Genes that make Tomatoes)</a>
<blockquote>「建構番茄的基因 (The Genes That Make Tomatoes)」資料庫是由 SGN 與耶路撒冷希伯來大學的 Zamir 實驗室合作託管。所有數據均收集自誘變專案，在田間針對特定發育階段（2001、2002 和 2003 年夏季）篩選了超過 150,000 株 M2 植株的突變表型。網站中包含該專案與突變族群的說明，以及新的搜尋引擎。3,500 個單基因突變株的收藏可依據詳細的表型目錄和性狀組合進行檢索。</blockquote>
</li>
<li><a href="http://zamir.sgn.cornell.edu/Qtl/Html/home.htm">即時數量性狀基因座 (Real Time QTL)</a>
<blockquote>即時 QTL (RTQ) 的目標是以番茄作為模式生物，在電腦模擬 (<em>in silico</em>) 中呈現描述遺傳變異組成成分的統計輸出範圍。</blockquote>
</li>
<li><a href="http://tgrc.ucdavis.edu/">TGRC 番茄遺傳資源中心 (TGRC)</a> [外部連結 (external link)]
<blockquote>C.M. Rick 番茄遺傳資源中心 (TGRC) 是野生近緣種、單基因突變株及各類番茄遺傳種原的基因庫。該中心以名譽教授 Charles M. Rick 博士命名，他透過研究與植物採集工作建立了大部分的收藏。TGRC 位於加州大學戴維斯分校蔬菜作物學系，亦整合至國家植物種原系統 (NPGS)。TGRC 透過向全球感興趣的科學家提供其種原的種子樣本以促進番茄研究。</blockquote>
</li>
</ul>
</td>
</tr>
</table>
 
END_HEREDOC
$page->footer();
