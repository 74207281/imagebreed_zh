use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('Phenotype submission format','Naama');
$page->header("SGN 表型資料提交指南 (SGN Phenotype Submission Guidelines)", "SGN phenotype submission guidelines");

print<<END_HEREDOC;

<p>
SGN 託管了一個<a href="/search/direct_search.pl?search=phenotypes/">表型資料庫 (phenotype database)</a>，用於展示記錄了表型特徵等資訊的個別植物種原（包含遺傳圖譜、QTL、基因座關聯之連結）。<br>
每個種原均與特定族群關聯，例如漸滲系 (introgression lines)、突變株和定位族群。<br>
    SGN 使用者可透過我們的網頁介面上傳<a href="/stock/0/new">新品系/種原或族群 (new accessions or populations)</a>（系統會先提示您登入，且需要 SGN 提交者帳號。如需取得提交者權限，請<a href="mailto:sgn-feedback\@solgenomics.net">與我們聯絡</a>）。<br/>
針對大型資料集，我們接受包含以下詳細資料的批次檔案提交：

<ul>
<li>族群描述說明 (Description of your population)</li>
<li>生物體/物種 (Organism)</li>
<li>聯絡人（若您尚無帳號，我們將為您建立新的提交者帳號）</li>
</ul>
<pre>
       <b>accession_id  description</b>
       accession1    free-text description of the phenotype
       accession2    description goes here
       .
       .
</pre>

我們將為您上傳品系，並將聯絡人指派為所有資訊的擁有者。<br><br>

您亦可為每個品系提交任意數量的影像。影像可隨時從資料庫中新增或刪除。
若有大量影像，請<a href="mailto:sgn-feedback\@solgenomics.net">與我們聯絡</a>以郵寄光碟或將影像上傳至 SGN FTP 站點。若您的檔案名稱未包含品系名稱（通常作為前綴，例如 myAccession1_leaf.jpg），我們亦需要一份包含影像資訊的檔案：

<pre>
  filename1   accession1
  filename2   accession1
  filename3   accession2
  .
  .
  .
</pre> 


若您已使用 <a href="/tools/onto/">「茄科表型 (Solanaceae Phenotype)」</a> 詞彙來描述您的品系，可依以下格式提交註解：

<pre> 
    accession1  SP000000X
    accession1  SP000000Y
    accession1  SP00000ZZ
    accession2  SP00000XY
    .
    .
    .
</pre>


<b>我們非常樂意<a href="mailto:sgn-feedback\@solgenomics.net">應您的需求</a>為表型資料庫新增資訊與功能！</b>

END_HEREDOC
$page->footer();
