use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('NSF 資助番茄基因組學計畫 (NSF-Sponsored Tomato Genomics Project)');
print<<END_HEREDOC;

  <center>
    <h1>歡迎來到 NSF 資助之番茄基因組學計畫<br />(Welcome to the NSF-Funded Tomato Genomics Project)</h1>

    <h3>開發番茄功能基因組學工具：<br />
    應用於果實發育、病原體反應以及與擬南芥的基因組同線性<br />
    (Development of tools for tomato functional genomics:<br />
    application to fruit development, responses to pathogens, and
    genomic synteny with <em>Arabidopsis</em>)</h3>

    <img src="/documents/help/about/tomato_project/nsf_9872617/../nsf-logo3.gif" width="91" height="100" border="0" alt="" />

  <hr />
</center>

  <p>歡迎瀏覽番茄基因組學計畫 (#9872617) 的資訊頁面。本計畫由<a href=
  "http://www.nsf.gov/funding/pgm_summ.jsp?pims_id=5338">美國國家科學基金會植物基因組研究計畫 (National Science Foundation Plant Genome Research Program)</a>資助。本頁面旨在提供有關專案目標、參與計畫主持人 (P.I.)、進度報告以及作為本計畫一部分所開發公共資源的資訊。同時提供與番茄遺傳學/基因組學相關的站點/資料庫連結。<br />
  (Welcome to the information pages for the Tomato Genomics Project (#9872617). This project is funded by the National Science Foundation Plant Genome Research Program.)</p>

<p>欲了解更多詳情，請點擊下方主題 (For more details, click on any of the topics below)：</p>
<ul>
        <li><a href="project.pl">計畫目標 (Project Goals)</a></li>
        <li><a href="http://ted.bti.cornell.edu/">表達資料庫 (Expression Database)</a></li>
        <li><a href="http://bti.cornell.edu/CGEP/CGEP.html">微陣列晶片 (Microarrays)</a></li>
        <li><a href="/maps/tomato_arabidopsis/index.pl">番茄-擬南芥同線性 (Tomato-Arabidopsis Synteny)</a></li>
        <li><a href="progress.pl">原始進度報告 (Original Progress Reports)</a></li>
        <li><a href="members.pl">諮詢委員會成員 (Members of Advisory Group)</a></li>
        <li><a href="websites.pl">相關網站連結 (Links to Related Websites)</a></li>
        <li><a href="publications.pl">出版物 (Publications)</a></li>	
</ul>

<br />

    

END_HEREDOC
$page->footer();