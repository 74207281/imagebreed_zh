
use strict;
use utf8;

use CXGN::Page;
use CXGN::Page::FormattingHelpers qw | page_title_html blue_section_html |;

my $page = CXGN::Page->new();

$page->header();

my $page_title = page_title_html("SGN 基因座與表型資料庫 (SGN Locus and Phenotype Database)");

print <<HTML;

$page_title
<br/>

<iframe src="//www.slideshare.net/slideshow/embed_code/key/rbDItCskr6kq5C" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/nm249/sgn-community-annotation-tutorial" title="SGN community Annotation Tutorial" target="_blank">SGN 社群註釋教學 (SGN community Annotation Tutorial)</a> </strong> 來自 (from) <strong><a href="//www.slideshare.net/nm249" target="_blank">Naama Menda</a></strong> </div>



<br/>
<hr/>

<dt>什麼是社群註釋？(What is community annotation?)</dt>
<dd>
社群註釋的概念是一門新興的學科，旨在促使研究社群參與將最新知識存入生物資料庫。<br/>
SGN 的主要工作之一是將茄科植物的表型資訊與其背後的基因相連結，並進一步連結至基因體。為了實現此目標，SGN 推出了<a href="/search/direct_search.pl?search=loci">基因座名稱與描述符 (locus names and descriptors)</a> 資料庫，以及<a href="/search/direct_search.pl?search=phenotypes">天然與誘發變異表型 (phenotypes of natural and induced variation)</a> 資料庫。這兩個資料庫均提供網頁介面，支援交叉參照、與番茄基因模型關聯，以及內部策劃的序列、文獻、本體論、基因網絡與 <a href="http://solcyc.sgn.cornell.edu">Solanaceae 生化途徑資料庫 (biochemical pathways database)</a> 資訊。我們所有的策展人工具均透過特別指定的「提交者 (submitter)」帳號開放進行線上社群註釋。<br/><br>
目前社群資料庫包含 5,548 個已進行表型分析的種原，以及 5,739 個已策劃的基因座，其中超過 300 個基因座由 70 多位活躍的提交者貢獻或註釋，創造了一個真正由社群驅動的資料庫。
</dd>

<dt>如何開始註釋我感興趣的基因？(How do I begin annotating my favorite gene?)</dt>
<ul>
<li> <b><a href= "/search/direct_search.pl?search=loci">搜尋基因座 (Search for the locus)</a></b>。
您可以獲得資料庫中任何基因座的<b>編輯權限 (editor privileges)</b>。<br/> 取得編輯權限非常簡單！只需在任何基因座頁面上點選「[申請編輯權限 (Request editor privileges)]」連結（位於「基因座編輯者」名稱旁），或<a href="mailto:sgn-feedback.sgn.cornell.edu">發送電子郵件給我們</a>，SGN 策展人將為您建立帳號。</li> 

<li><b>提交新基因座 (Submit a new locus)</b>。在 SGN 上找不到您感興趣的茄科基因座嗎？我們鼓勵您在<a href="/locus/0/view">此處</a><b>提交</b>有關茄科及相關物種遺傳基因座的資訊（請注意，所有資料提交均需擁有 <a href="/solpeople/new-account.pl">SGN 帳號</a>）。如需提交大量資料集，請<a href="mailto:sgn-feedback.sgn.cornell.edu">聯絡 SGN</a>。
</li>
</ul>
<br/>

<dd><img src="/documents/img/locus_edit.jpg" border="1"  width="80%" ></dd>

<br/>

<dt>我可以在不是基因座編輯者的情況下提交資訊嗎？(Can I submit information without being the locus-editor?)</dt>
<ul>
<li>您不想擔任基因座編輯者，但仍希望<b>提交相關資訊</b>（例如文獻或序列）嗎？<br>
您只需使用提交者帳號登入即可。<a href="/solpeople/new-account.pl">SGN 帳號</a>建立十分簡單，但為了提交資訊，我們需要進行簡短的驗證步驟。請<a href="mailto:sgn-feedback.sgn.cornell.edu">發送電子郵件至 SGN</a> 以取得存取社群註釋功能的權限。
</li>
</ul>
<br/>

<dd><img src="/documents/img/seq_submit.jpg" border="1"  width="80%"></dd>

<br/>

<dt>如果沒有 SGN 提交者權限，我可以發表資料嗎？(Can I post data without SGN submitter privileges?)</dt>
<ul>
<li>您可以隨時在任何基因座或表型頁面上提交<b>使用者評論 (user comments)</b>。您只需要使用 SGN 使用者帳號登入。
使用者評論將顯示在每個頁面的底部。
</li>

</ul>


<br/>
<hr>
<br/>

<a name="phenotype"></a>
<dt>SGN 表型資料庫同樣由社群驅動！(SGN phenotype database is also community-driven!)</dt>
<dd>SGN 收藏了數千個茄科<a href="../search/direct_search.pl?search=phenotypes">已表型分析的種原 (phenotyped accessions)</a>，涵蓋多個選育及突變族群。在適用的情況下，表型均會連結至 SGN 基因座。SGN 提交者可以編輯任何種原、上傳圖片，並新增與基因座資訊的交互連結。<br/></dd>

<dt>提交表型 (Submit Phenotype)</dt>
<dd>新的表型與植物種原可在<a href="/stock/0/new">此處 (here)</a> 提交。如需提交大量資料集，請<a href="mailto:sgn-feedback.sgn.cornell.edu">聯絡 SGN</a>。<br/>
表型註釋的運作方式與基因座註釋類似。表型提交者即為種原的擁有者，並具有完整的線上編輯權限。<br />
如需批次提交表型，您可以將<a href= "/content/phenotype_submissions.pl">包含資訊的檔案</a>及圖片儲存於光碟寄送給我們，我們將為您上傳資料。
</dd>

<dd><br/></dd>
<dd><img src="/documents/img/new_pheno.jpg" border="1" width="80%"></dd>

<br/>


<br/><hr/>

<dt>如需關於可由社群編輯的基因座與表型資料庫的詳細資訊，請參閱 <a href="http://docs.google.com/Doc?id=ddhncntn_0cz2wj6">SGN 提交指南 (SGN submission guide)</a>。</dt>
HTML


$page->footer();
