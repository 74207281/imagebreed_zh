use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('SGN 單一基因方法 (SGN Unigene Methods)');
print<<END_HEREDOC;

     <br />
     <center>
     <table summary="" class="boxbgcolor2" width="100%">
     <tr>
     <td width="25%">&nbsp;</td>
     <td width="50%" class="left">
	  <div class="boxcontent">
	  	    
	    <div class="subheading">
	    <u>SGN 單一基因方法 (SGN Unigene Methods)</u> 
	    </div>
	    <div class="boxsubcontent">
	    <a href="/methods/unigene/unigene-builds.pl">SGN 單一基因構建 (SGN Unigene Builds)</a> - Sol Genomics Network 單一基因構建代表茄科物種表現基因的「最小冗餘」集合，由 SGN 資料庫中的 EST/cDNA 序列資料構建而成。(The Sol Genomics Network unigene builds represent "minimally redundant" collections of expressed genes in Solanaceous species, constructed from EST/cDNA sequence data present in SGN's databases.)
	    </div>
            <div class="boxsubcontent">
            <a href="/methods/unigene/unigene-methods.pl">單一基因組裝流程概述 (Unigene Assembly Process Overview)</a> - 提供 SGN 單一基因組裝流程的概述。(Gives an overview of SGN's unigene assembly process.)
	    </div>
	    <div class="boxsubcontent">
            <a href="/methods/unigene/unigene-precluster.pl">預聚類與遞移閉包聚類 (Preclustering and Transitive Closure Clustering)</a> - 預聚類是一種用於將輸入資料分割成足夠小的分組以便組裝程式進行處理的技術。(Preclustering is a technique used to partition the input data into groups small enough for the assembly program to process.)
	    </div>
	    <div class="boxsubcontent">
            <a href="/methods/unigene/unigene-validation.pl">組裝流程驗證 (Assembly Process Validation)</a> - 此資料旨在表徵兩個獨立流程輸出之間的差異。(This data attempts to characterize the differences in outputs of two separate processes)
	    </div>

	    <div class="boxsubcontent">
            <a href="/methods/unigene/unigene-process-2.pl">SGN 組裝流程第 2 版 (SGN Assembly Process Version 2)</a></div>

	  </div>
</td>
<td width="25%">&nbsp;</td>
</tr>
</table>
</center>

END_HEREDOC
$page->footer();