use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('SGN 內容 (SGN Content)');
print<<END_HEREDOC;

  
     

     <br />
     <center>
     <table summary="" class="boxbgcolor2" width="100\%">
     <tr>
     <td width="25\%">&nbsp;</td>
     <td width="50\%" class="left">
	  <div class="boxcontent">
	  	    
	    <div class="subheading">
	    <u>SGN 內容 (SGN Content)</u> 
	    </div>
	    <div class="boxsubcontent">
            <a href="/content/unigene_builds/Lycopersicon_Combined.pl">番茄屬綜合 Unigene 組裝系列 (Lycopersicon Combined Unigene Build Series)</a> - 該 unigene 組裝系列整合了來自多毛番茄 (Lycopersicon hirsutum)、潘氏番茄 (Lycopersicon pennellii) 及普通番茄 (Lycopersicon esculentum) cDNA 基因庫的 EST。
	    </div>
              
          </div>
</td>
<td width="25\%">&nbsp;</td>
</tr>
</table>
</center>

END_HEREDOC
$page->footer();