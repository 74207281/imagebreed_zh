use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('websites.html','html2pl converter');
$page->header('相關網站連結 (Links to related Websites)');
print<<END_HEREDOC;

  <h1>相關網站連結 (Links to related Websites)</h1>

  <h2>搜尋資料庫 (Search the Databases):</h2>

  <ul>
    <li><a href="http://www.tigr.org/tigr-scripts/tgi/T_index.cgi?species=tomato">TIGR 番茄基因索引 (The Institute for Genomic Research's (TIGR) Tomato Gene Index)</a></li>

    <li><a href="http://www.ncbi.nlm.nih.gov/">美國國家生物技術資訊中心 (National Center for Biotechnology Information, NCBI)</a></li>

    <li><a href="/index.pl">茄科基因組網絡 (The Solanaceae Genome Network, SGN)</a></li>
  </ul>

  <h2>康乃爾大學相關網站 (Related Cornell University Sites):</h2>

  <ul>
    <li><a href="http://www.tc.cornell.edu/">康乃爾超級運算中心 (Supercomputing at Cornell)</a></li>

    <li><a href="http://www.genomics.cornell.edu/">康乃爾基因組學倡議 (Cornell Genomics Initiative)</a></li>

    <li><a href="http://bti.cornell.edu/CGEP/CGEP.html">博伊斯湯普森研究所微陣列晶片核心實驗室 (Boyce Thompson Institute Microarray Facility, CGEP)</a></li>
  </ul>

  <p>若您希望在本頁面新增連結，請寄送電子郵件至 <a href=
  "mailto:dci1\@cornell.edu">dci1\@cornell.edu</a>。感謝您的建議。<br />
  (If you would like to add to this page please e-mail dci1\@cornell.edu. We appreciate your suggestions.)</p>

    

END_HEREDOC
$page->footer();