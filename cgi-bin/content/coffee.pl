use strict;
use utf8;
use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/ page_title_html blue_section_html /;

my $page=CXGN::Page->new('SGN coffee data','Lukas');
$page->header('SGN 咖啡資料 (SGN Coffee Data)');

print page_title_html("SGN 上的咖啡資料 (Coffee data on SGN)");

print<<END_HEREDOC;

<table summary=""><tr><td valign="middle">
<img src="/documents/img/coffee_small.jpg" alt="" />
    </td><td width="30">&nbsp;</td><td valign="top">
<p>
[2005 年 11 月 7 日]。康乃爾大學 (Cornell University) 與雀巢公司 (Nestle SA) 在 Sol Genomics Network 上向公眾發布了 47,000 條咖啡 (<i>Coffea canephora</i> var robusta) EST 序列。([Nov 7, 2005]. Cornell University and Nestle SA are releasing 47,000 coffee (Coffea canephora var robusta) EST sequences to the public on the Sol Genomics Network.)
</p>
<h4>摘要 (Abstract)</h4>
<p>
咖啡 EST 資料庫已建立，該資料庫基於來自五個不同發育階段/組織的約 47,000 個 cDNA 選殖株序列，特別著重於發育中的種子。經電腦組裝後，這些序列對應於 13,175 個單一基因 (unigenes)，並已針對功能註釋、表現譜及演化進行分析。與擬南芥 (Arabidopsis) 相比，咖啡單一基因編碼更高比例與蛋白質修飾/代謝轉換相關的蛋白質，這一觀察結果可能解釋了咖啡及其相關物種中發現的高度代謝物多樣性。與擬南芥相比，發現數個基因家族在咖啡中有所擴展或為咖啡所特有。這些家族中有很高比例編碼與抗病性相關的蛋白質。這些家族可能在像咖啡這樣的熱帶多年生物種所承受的強烈病原體壓力下快速擴展和演化。最後，將咖啡基因譜與擬南芥及茄科物種（例如番茄）進行了比較。與擬南芥不同，番茄與咖啡幾乎具有完美的基因對基因匹配。這些結果與以下事實一致：咖啡和番茄具有相似的基因組大小、染色體核型（番茄，n=12；咖啡，n=11）和染色體架構。此外，兩者均屬於雙子葉植物的菊類分支 I (Asterid I clade)。因此，咖啡（茜草科 Rubiaceae）和番茄（茄科 Solanaceae）的生物學可以統一在一個共享發現、資源和資訊的共同網絡中。(An EST database has been generated for coffee based on sequences from approximately 47,000 cDNA clones...)
</p>
<p>
該資料集在以下出版物中有詳細說明：(The dataset is described in detail in the following publication:) </p>
<p class="boxcontent">
Coffee and tomato share common gene repertoires as revealed by deep sequencing of seed and cherry transcripts.
Lin C, Mueller LA, Carthy JM, Crouzillat D, Petiard V, Tanksley SD. 
Theor Appl Genet. 2005 Nov 5;:1-17.
</p>
<p>
    本文的 PDF 檔案以<a href="http://www.plos.org/oa/index.html">開放取用格式 (Open Access format)</a>提供，任何人均可免費獲取。(A pdf file of this article is available in Open Access format, free of charge to anyone.)
</p>


<h4>資料存取 (Data access)</h4>

咖啡 EST、電腦推導的單一基因、蛋白質序列、蛋白質結構域和基因本體論 (GO) 註釋均可從 SGN <a href="ftp://ftp.sgn.cornell.edu/coffee/">FTP 伺服器 (ftp server)</a>立即下載。資料將在近期內新增至 SGN 資料庫中。(The coffee ESTs, computationally derived unigenes, protein sequences, protein domains and Gene Ontology annotations are immediately downloadable from the SGN ftp server.)

</td></tr></table>

END_HEREDOC


$page->footer();
