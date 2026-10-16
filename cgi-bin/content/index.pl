use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('SGN 內容 (SGN Content)');
print<<END_HEREDOC;

     <br />
     <center>
     <table summary="" class="boxbgcolor2" width="100%">
     <tr>
     <td width="25%">&nbsp;</td>
     <td width="50%" class="left">
	  <div class="boxcontent">
	  	    
	    <div class="subheading">
	    <u>SGN 內容 (SGN Content)</u> 
	    </div>
	    <div class="boxsubcontent">
            <a href="/content/unigene_builds/Lycopersicon_Combined.pl">番茄綜合單一基因構建系列 (Lycopersicon Combined Unigene Build Series)</a> - 此單一基因構建系列整合了源自 Lycopersicon hirsutum、Lycopersicon pennellii 和 Lycopersicon esculentum cDNA 基因庫的 EST。(This unigene build series incorporates ESTs derived from Lycopersicon hirsutum, Lycopersicon pennellii, and Lycopersicon esculentum cDNA libraries.)
	    </div>
              
          </div>
</td>
<td width="25%">&nbsp;</td>
</tr>
</table>
</center>

END_HEREDOC
$page->footer();