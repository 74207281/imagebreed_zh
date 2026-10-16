use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('Sol Genomics Network - 補充資料 (Plant Cell Supplement)');
print<<END_HEREDOC;

  
     

     <br />
     <center>
     <table summary="" class="boxbgcolor2" width="100\%">
     <tr>
     <td width="25\%">&nbsp;</td>
     <td width="50\%" class="left">
	  <div class="boxcontent">
	  	    
	    <div class="subheading">
	    <u>Plant Cell 補充資料 (Plantcell Supplement)</u> 
	    </div>
	    <div class="boxsubcontent">
            <a href="/supplement/plantcell-14-1441/bac_annotation.pl">6 個番茄 BAC 序列的註解 (Annotation of 6 Tomato BAC sequences)</a> - 本頁面連結到代表本文中提及的六個 BAC 之數據分析與註解結果的檔案。Artemis 檔案總結了 BAC 的註解，並可使用來自 Sanger 中心的 DNA 序列檢視器 Artemis [1] 進行檢視。[下載 (Download)] 這些檔案亦可以純文字格式檢視。BLAST 檔案是針對 SGN 上提供的各個資料庫進行序列相似度分析的 BLAST 輸出結果。[2]
	    </div>
              
          </div>
</td>
<td width="25\%">&nbsp;</td>
</tr>
</table>
</center>

END_HEREDOC
$page->footer();