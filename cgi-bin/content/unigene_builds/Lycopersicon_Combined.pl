use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('Lycopersicon_Combined.html','html2pl converter');
$page->header('番茄屬綜合 Unigene 組裝系列 (Lycopersicon Combined Unigene Build Series)');
print<<END_HEREDOC;
  
  <strong>番茄屬綜合 Unigene 組裝系列 (Lycopersicon Combined Unigene Build Series)</strong>

  <p>該 unigene 組裝系列整合了來自多毛番茄 (<em>Lycopersicon hirsutum</em>)、潘氏番茄 (<em>Lycopersicon pennellii</em>) 及普通番茄 (<em>Lycopersicon esculentum</em>) cDNA 基因庫的 EST。目前尚未納入其他序列。這些基因庫是在<a href="http://www.cornell.edu/">康乃爾大學 (Cornell University)</a> 構建，作為 NSF 資助之<a href="/about/tomato_project/index.pl">番茄基因體專案 (Tomato Genomics Project #9872617)</a> 的一部分，並主要由 <a href="http://www.tigr.org/">TIGR</a> 進行定序。在專案獲得資助前的準備階段，Cereon 和 Novartis 亦提供了先導定序。所有序列皆為 5' 端讀序，僅約 1\% 隨機選取的選殖株亦進行了 3' 端定序。</p>

  <p>此版本新功能摘要 (Summary of new features in this build)</p>

  <ul>
    <li>來自重新排列「TUS」基因庫的新 5' 與 3' 端序列</li>

    <li>新的修剪與品質評估流程</li>

    <li>新的嵌合體篩選流程，減少組裝過程中引入嵌合序列的數量</li>

    <li>篩除 rRNA 及選殖宿主污染</li>

    <li>針對 NR 及其他資料庫的 BLAST 結果會快取並自動顯示</li>
  </ul><strong>新序列 (New Sequences)</strong><br />

  <p>此組裝版本最新迭代中的新特點，是建立並納入了「重新排列 (re-arrayed)」基因庫，該基因庫包含從最初定序的微孔盤中選出的選殖株，涵蓋了我們所有的 cDNA 基因庫。選出的選殖株跨越了我們先前的番茄屬 unigene 組裝版本，以及公開可用的<a href="http://bti.cornell.edu/CGEP/CGEP.html">番茄 cDNA 微陣列 (Tomato cDNA microarray)</a> 上使用的所有選殖株。目前正致力於從 5' 和 3' 兩端重新定序這組選殖株，並將這些新的配對讀序納入我們的 unigene 組裝中。雖然此項額外定序專案尚未完成，但目前的番茄屬綜合組裝版本已納入了 11,732 條新 5' 端讀序與 9,897 條新 3' 端讀序。</p>

  <p>TOM1 微陣列選殖株的重新定序由法國國家農業研究院 (<a href="http://www.inra.fr">INRA</a>) 資助。如需進一步資訊，請聯絡：</p>
  <pre>
Mondher Bouzayen (bouzayen\@ensat.fr)
Genomics and Fruit Biotechnology Lab.
UMR 990 INRA/INP-ENSAT
Avenue de l'agrobiopole
BP107 Auzeville-Tolosan
F-31326 Castanet Tolosan Cedex, France
</pre>

  <p>非微陣列 TUS 選殖株的 5'/3' 端定序額外資金由義大利農林部 (MiPAF) 作為 DM357/7303/01 專案的一部分提供，並由印度 <a href="http://www.avesthagen.com/">Avesthagen Technologies Ltd.</a> 執行。如需進一步資訊，請聯絡：</p>
  <pre>
Chris Bowler (chris\@szn.it)
Stazione Zoologica
Naples, Italy 
</pre>

  <p><strong>新修剪與品質評估 (New trimming and quality evaluation)</strong><br /></p>

  <p>此版本中另一項新功能是完全重新設計的原始數據處理管線。目前整合至 SGN unigene 的所有讀序都是直接從原始層析圖檔案中處理的。cDNA 插入片段的高品質部分是透過我們自訂的插入片段恢復流程進行恢復。[<font color="gray">詳細說明頁面建置中</font>]<br /></p>

  <p><strong>嵌合體篩選 (Chimera Screening)</strong><br /></p>

  <p>此管線中亦整合了 3 個針對嵌合序列的獨立篩選步驟。雖然這些篩選尚未在實驗室中進行驗證，但 EST 預先叢集化期間收集的統計數據顯示，假性錯誤合併 EST 叢集的情況大幅減少。被視為推測性嵌合體的 EST 將被排除在組裝流程之外，從而減少 unigene 輸出中將異常 cDNA 接合誤判為新基因的錯誤表示。[<font color="gray">詳細說明頁面建置中</font>]<br /></p>

  <p><strong>儲存 BLAST 結果 (BLAST results stored)</strong><br /></p>

  <p>在目前的番茄屬綜合組裝版本及未來的 unigene 組裝版本中，針對常用資料庫（例如 GenBank 非冗餘胜肽資料庫 genbank/nr 與阿拉伯芥預測蛋白質組 TAIR）的 BLAST 分析皆已預先計算並儲存於 SGN 資料庫中。在存在匹配的情況下，已儲存的匹配結果可在 unigene 搜尋結果頁面上直接檢視，作為簡便的第一階段註解。[<a href="/search/unigene.pl?unigene_id=145962&amp;force_image=1">檢視範例</a>]<br /></p>

  <p><strong>使用此 unigene 組裝版本 (Using this unigene build)</strong><br /></p>

  <p>使用 unigene 組裝版本最直接的方式就是進行搜尋。最簡單的搜尋方式是使用 <a href="/tools/blast/">SGN BLAST 介面</a> 並選擇「Lycopersicon Combined」作為目標資料庫。請注意，此 BLAST 資料庫為核苷酸序列，因此您必須使用 BLASTN、TBLASTN 或 TBLASTX 進行檢索。比對出的匹配結果將提供前往該 unigene 詳細頁面的連結。</p>

  <p>使用此 unigene 組裝版本的另一種方式是使用 SGN-U# 識別碼<a href="/search/direct_search.pl">直接搜尋</a>，或使用 EST 識別碼搜尋 EST 資料庫。前者要求您先前已識別該 unigene 並記錄了其 SGN-U#，或在某處參考文獻中看到此識別碼。而 EST 資料庫除了支援 SGN 原生的 SGN-E# 識別碼外，還可使用 GenBank 登錄號、機構指派的識別碼及選殖株種原識別碼進行搜尋。</p>

  <p>最後，使用 TIGR 番茄基因索引的研究人員亦可使用 TIGR 的 TC# 搜尋此組裝版本及其他番茄屬組裝版本。TIGR 目前的任何 TC# 或 TIGR 仍維護追蹤資訊的舊版本編號，均可用於鑑定 SGN unigene。請注意，此對應並非一對一，而是多對多。此外，我們的組裝版本包含近 20,000 條未包含在 TIGR 最新番茄基因索引發布版本中的序列，而其組裝版本則包含我們在此版本中未納入的外源輸入序列。<br /></p>
  
  <br />
  
END_HEREDOC
$page->footer();
