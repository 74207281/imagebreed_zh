use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('SGN 社群 (SGN Community)');
print<<END_HEREDOC;

  
     

     <br />
     <center>
     <table summary="" class="boxbgcolor2" width="100\%">
     <tr>
     <td width="25\%">&nbsp;</td>
     <td width="50\%" class="left">
	  <div class="boxcontent">
	  	    
	    <div class="subheading">
	    <u>SGN 社群 (SGN Community)</u> 
	    </div>
	    
            <div class="boxsubcontent">  
	    <a href="/static_content/community/genomics_forum/dec17_latex.pdf"><i>Latex, Bibtex, and Friends</i></a> - 關於 LaTeX 與 BibTeX 的報告 (A report on latex and bibtex)。
	    </div>
	    <div class="boxsubcontent">
	    <a href="/static_content/community/genomics_forum/slides/repeat_analysis.pdf"><i>Approaches to Repeat Finding</i></a> - 關於重複序列尋找方法的報告 (A report on repeat finding)。
	    </div>
            <div class="boxsubcontent">  
	    <a href="/community/links/genefinding.pl">基因尋找連結 (Gene Finding Links)</a> - 提供基因尋找工具、引子設計及啟動子預測的連結 (Provides links to genefinding tools, primer design, and promoter predictions)。
	    </div>
            <div class="boxsubcontent">  
	    <a href="/community/links/journals.pl">線上期刊連結 (Online Journal Links)</a> - 提供線上期刊網站的連結 (Provides links to journals on the web)。
	    </div>
	    <div class="boxsubcontent">  
	    <a href="/community/links/related_sites.pl">茄科資源連結 (Solanaceae Resources Links)</a> - 提供茄科分類系統、描述及影像連結。亦包含番茄、馬鈴薯、辣椒、矮牽牛、咖啡、種原及其他序列資源連結。  
	    </div>
	    <div class="boxsubcontent">  
	    <a href="/community/links/seed_companies.pl">種苗公司連結 (Seed Companies Links)</a> - 提供茄科種苗公司清單連結 (Provides links to a list of Solanaceae Seed companies)。 
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
