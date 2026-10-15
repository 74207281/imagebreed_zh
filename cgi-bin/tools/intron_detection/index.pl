use strict;
use warnings;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new("Sol Genomics Network","Tyler");
$page->header();
print <<END_HEREDOC;

     <br />
     <center>
     <table class="boxbgcolor2" width="100%" summary="">
     <tr>
     <td width="25%">&nbsp;</td>
     <td width="50%" class="left">
	  <div class="boxcontent">
	  	    
	    <div class="subheading">
	    <u>SGN 內含子偵測工具(SGN Intron Detection Tools)</u> 
	    </div>
	    <div class="boxsubcontent">
              <a href="/tools/intron_detection/find_introns.pl">茄科 EST 內含子搜尋器(Intron Finder for Solanceae ESTs)</a> - SGN 內含子搜尋器透過 BLAST 搜尋與輸入 DNA 轉譯蛋白質序列相似的擬南芥 (Arabidopsis Thaliana) 蛋白質來運作。(The SGN Intron Finder works by doing a blast search for Arabidopsis Thaliana proteins that are similar to the translated protein sequence of the DNA input.)
            </div>
          </div>
</td>
<td width="25%">&nbsp;</td>
</tr>
</table>
</center>


END_HEREDOC


$page->footer();
