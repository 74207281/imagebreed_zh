use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('SGN 突變株 (SGN Mutants)');
print<<END_HEREDOC;

  
     

     <br />
     <center>
     <table summary="" class="boxbgcolor2" width="100\%">
     <tr>
     <td width="25\%">&nbsp;</td>
     <td width="50\%" class="left">
	  <div class="boxcontent">
	  	    
	    <div class="subheading">
	    <u>SGN 突變株 (SGN Mutants)</u> 
	    </div>
	    <div class="boxsubcontent">
            <a href="/mutants/mutants_main.pl">突變株 (Mutants)</a> - 此頁面提供建構番茄的基因 (Genes that make tomatoes)、即時 QTL (Real Time QTL) 及 TGRC 相關之描述與連結。</div>
              
          </div>
</td>
<td width="25\%">&nbsp;</td>
</tr>
</table>
</center>

END_HEREDOC
$page->footer();