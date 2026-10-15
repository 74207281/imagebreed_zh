use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new("Sol Genomics Network","Tyler");
$page->header('SGN 批次下載 (SGN Bulk Download)');
print <<END_HEREDOC;

     <br />
     <center>
     <table class="boxbgcolor2" width="100%" summary="">
     <tr>
     <td width="25%">&nbsp;</td>
     <td width="50%" class="left">
          <div class="boxcontent">
        
            <div class="subheading">
            <u>SGN 批次下載 (SGN Bulk)</u> 
            </div>
            <div class="boxsubcontent">
              <a href="/bulk/input.pl">批次下載 (Bulk Download)</a> - 透過識別碼清單下載資訊，或透過 FTP 下載完整資料集。<br />(Download information for a list of identifiers, or for complete datasets with FTP.)
            </div>
       
          </div>
</td>
<td width="25%">&nbsp;</td>
</tr>
</table>
</center>

END_HEREDOC

$page->footer();
