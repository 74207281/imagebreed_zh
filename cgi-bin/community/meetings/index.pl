use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('SGN 會議與研討會 (SGN Meetings)');
print<<END_HEREDOC;

  
     

     <br />
     <center>
     <table summary="" class="boxbgcolor2" width="100\%">
     <tr>
     <td width="25\%">&nbsp;</td>
     <td width="50\%" class="left">
	  <div class="boxcontent">
	  	    
	    <div class="subheading">
	    <u>SGN 會議與研討會 (SGN Meetings)</u> 
	    </div>
	    <div class="boxsubcontent">
            <a href="/static_content/community/meetings/TBRT_brochure.pdf">TBRT 手冊 (TBRT Brochure)</a> - 番茄育種家圓桌會議手冊 (Brochure on the Tomato Breeders Roundtable)。
	    </div>
              
          </div>
</td>
<td width="25\%">&nbsp;</td>
</tr>
</table>
</center>

END_HEREDOC
$page->footer();