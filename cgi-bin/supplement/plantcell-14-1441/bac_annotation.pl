use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('bac_annotation.html','html2pl converter');
$page->header('Sol Genomics Network - BAC 序列註解 (BAC Sequence Annotations)');
print<<END_HEREDOC;

<center>

<table summary="" width="720" cellpadding="0" cellspacing="0"
border="0">
<tr>
<td>
<h2>6 個番茄 BAC 序列的註解 (Annotation of 6 tomato BAC sequences)</h2>
<br />
<p>本網頁上的資訊附屬於論文：基於大量 EST 收集分析與選擇性基因體定序對番茄基因體中基因數量、組織與演化的推論 (Deductions about the number, organization and evolution of genes in the tomato genome based on analysis of a large EST collection and selective genomic sequencing) (Plant Cell 期刊 [即將出版])。下方連結為代表本文中提及的六個 BAC 之數據分析與註解結果的檔案。Artemis 檔案總結了 BAC 的註解，並可使用來自 <a href="http://www.sanger.ac.uk/">Sanger 中心 (Sanger center)</a> 的 DNA 序列檢視器 <a href="http://www.sanger.ac.uk/Software/Artemis/">Artemis</a> [1] 進行檢視。<a href="http://www.sanger.ac.uk/Software/Artemis/v4/">[下載 (Download)]</a> 這些檔案亦可以純文字格式檢視。BLAST 檔案是針對 <a href="/">SGN</a> 上提供的各個資料庫進行序列相似度分析的 BLAST 輸出結果。[2]</p>
<br />
<br />
Artemis 數據 (Artemis Data)<br />
<pre>
         <a href="/static_content/supplement/plantcell-14-1441/artmenis/gi_9858768.txt">gi_9858768</a>
         <a href="/static_content/supplement/plantcell-14-1441/artmenis/gi_15987769.txt">gi_15987769</a>
         <a href="/static_content/supplement/plantcell-14-1441/artmenis/gi_15987770.txt">gi_15987770</a>
         <a href="/static_content/supplement/plantcell-14-1441/artmenis/gi_15987771.txt">gi_15987771</a>
         <a href="/static_content/supplement/plantcell-14-1441/artmenis/gi_15987772.txt">gi_15987772</a>
         <a href="/static_content/supplement/plantcell-14-1441/artmenis/gi_15987773.txt">gi_15987773</a>
         <a href="/static_content/supplement/plantcell-14-1441/artmenis/gi_15987774.txt">gi_15987774</a>
</pre>
<p>對比 GenPept 之 BLASTX (BLASTX against GenPept)<br /></p>
<pre>
         <a href="/static_content/supplement/plantcell-14-1441/GenPept/gi_9858768.txt">gi_9858768</a>
         <a href="/static_content/supplement/plantcell-14-1441/GenPept/gi_15987769.txt">gi_15987769</a>
         <a href=
"/static_content/supplement/plantcell-14-1441/GenPept/gi_15987770&amp;1.txt">gi_15987770 and gi_15987771</a>
         <a href="/static_content/supplement/plantcell-14-1441/GenPept/gi_15987772.txt">gi_15987772</a>
         <a href="/static_content/supplement/plantcell-14-1441/GenPept/gi_15987773.txt">gi_15987773</a>
         <a href="/static_content/supplement/plantcell-14-1441/GenPept/gi_15987774.txt">gi_15987774</a>
</pre>
<p>對比番茄重疊群 (Lycopersicon Esculentum Contigs, Unigene Build 2) 之 BLASTN (BLASTN against Lycopersicon Esculentum Contigs)<br /></p>
<pre>
         <a href="/static_content/supplement/plantcell-14-1441/le_con_2/gi_9858768.txt">gi_9858768</a>
         <a href="/static_content/supplement/plantcell-14-1441/le_con_2/gi_15987769.txt">gi_15987769</a>
         <a href=
"/static_content/supplement/plantcell-14-1441/le_con_2/gi_15987770&amp;1.txt">gi_15987770 and gi_15987771</a>
         <a href="/static_content/supplement/plantcell-14-1441/le_con_2/gi_15987772.txt">gi_15987772</a>
         <a href="/static_content/supplement/plantcell-14-1441/le_con_2/gi_15987774.txt">gi_15987774</a>
</pre>
<p>對比擬南芥平鋪路徑 (Arabidopsis Tiling Path, SGN) 之 TBLASTX (TBLASTX against Arabidopsis Tiling Path)<br /></p>
<pre>
         <a href="/static_content/supplement/plantcell-14-1441/atpath/gi_9858768.txt">gi_9858768</a>
         <a href="/static_content/supplement/plantcell-14-1441/atpath/gi_15987769.txt">gi_15987769</a>
         <a href=
"/static_content/supplement/plantcell-14-1441/atpath/gi_15987770&amp;1.txt">gi_15987770 and gi_15987771</a>
         <a href="/static_content/supplement/plantcell-14-1441/atpath/gi_15987772.txt">gi_15987772</a>
         <a href="/static_content/supplement/plantcell-14-1441/atpath/gi_15987773.txt">gi_15987773</a>
         <a href="/static_content/supplement/plantcell-14-1441/atpath/gi_15987774.txt">gi_15987774</a>
</pre>
<p>對比 SGN EST 資料庫之 BLASTN (BLASTN against SGN EST database)<br /></p>
<pre>
         <a href="/static_content/supplement/plantcell-14-1441/sgn_estdb/gi_9858768.txt">gi_9858768</a>
         <a href="/static_content/supplement/plantcell-14-1441/sgn_estdb/gi_15987769.txt">gi_15987769</a>
         <a href=
"/static_content/supplement/plantcell-14-1441/sgn_estdb/gi_15987770&amp;1.txt">gi_15987770 and gi_15987771</a>
         <a href="/static_content/supplement/plantcell-14-1441/sgn_estdb/gi_15987772.txt">gi_15987772</a>
         <a href="/static_content/supplement/plantcell-14-1441/sgn_estdb/gi_15987773.txt">gi_15987773</a>
         <a href="/static_content/supplement/plantcell-14-1441/sgn_estdb/gi_15987774.txt">gi_15987774</a>
</pre>
<br />
<p>[1] K. Rutherford, J. Parkhill, J. Crook, T. Horsnell, P. Rice,
M-A. Rajandream and B. Barrell (2000) Artemis: sequence
visualization and annotation (Bioinformatics 16 (10) 944-945.
<a href=
"http://bioinformatics.oxfordjournals.org/cgi/content/abstract/16/10/944">
摘要 (Abstract)</a>)<br /></p>
<p>[2] 自本著作發表以來，SGN 目前提供的 BLAST 資料庫可能已經變更或更新。</p>
</td>
</tr>
</table>

</center>
END_HEREDOC
$page->footer();
