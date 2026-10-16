use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('相關連結 (Links)');
print<<END_HEREDOC;

  
     

     <br />
     <center>
     <table summary="" class="boxbgcolor2" width="100\%">
     <tr>
     <td width="33\%">&nbsp;</td>
     <td width="33\%" class="left">
	  <div class="boxcontent">
	  <br />
	    
	    <div class="subheading">
	    <u>相關連結 (Links)</u> 
	    </div>
	    <div class="boxsubcontent">
              <a class="creativitylinks" href="genefinding.pl">基因尋找工具 (Genefinding tools)<br />引子設計 (Primer Design)<br />啟動子預測 (Promoter Predictions)</a><br />
              <a class="creativitylinks" href="journals.pl">線上期刊 (Journals on the Web)</a><br />
              <a class="creativitylinks" href="seed_companies.pl">茄科種苗公司清單 (List of Solanaceae Seed companies)</a><br />
              <a class="creativitylinks" href="related_sites.pl">網路上的茄科資源 (Solanaceae Resources on the Web)	</a><br />
            </div>
          </div>
</td>
<td width="33\%">&nbsp;</td>
</tr>
</table>
</center>

END_HEREDOC
$page->footer();