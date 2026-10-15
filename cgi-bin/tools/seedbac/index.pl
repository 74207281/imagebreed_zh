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
	    <u>SGN 種子 BAC 工具(SGN Seedbac Tools)</u> 
	    </div>
	    <div class="boxsubcontent">
              <a href="/tools/seedbac/chr_sbfinder.pl">染色體種子 BAC 搜尋器(Chromosome Seedbac Finder)</a> - 此工具列出給定染色體的所有定位 BAC，以協助識別種子 BAC。(This tool lists all anchored bacs for a given chromosome to help identify seed bacs.)
            </div> 
            <div class="boxsubcontent"> 
              <a href="/tools/seedbac/sbfinder.pl">種子 BAC 搜尋器(Seedbac Finder)</a> - 此工具在給定標記名稱的情況下建議種子 BAC。(This tool will suggest a seed bac given a marker name.)
            </div>
	   
          </div>
</td>
<td width="25%">&nbsp;</td>
</tr>
</table>
</center>


END_HEREDOC


$page->footer();
