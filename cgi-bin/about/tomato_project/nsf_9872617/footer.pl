use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('footer.html','html2pl converter');
$page->header('Sol Genomics Network');
print<<END_HEREDOC;
<br />

<hr width="50\%" />

  <table summary="" align="center" cellspacing="5" cellpadding="5">
    <tr>
      <td align="center"><a href="index.pl">首頁 (Home)</a></td>
      <td align="center"><a href="progress.pl">進度報告 (Progress Reports)</a></td>
      <td align="center"><a href=
      "/maps/tomato_arabidopsis/index.pl">番茄-擬南芥同線性 (Tomato-Arabidopsis Synteny)</a></td>
      <td align="center"><a href="http://ted.bti.cornell.edu/">資料庫 (Database)</a></td>
    </tr>
  </table>

  <table summary="" align="center" cellspacing="5" cellpadding="5">
    <tr>
      <td align="center"><a href="members.pl">諮詢委員會成員 (Members of Advisory Group)</a></td>

      <td align="center"><a href="websites.pl">相關網站連結 (Links to Related Websites)</a></td>
      <td align="center"><a href="project.pl">專案說明 (Project)</a></td>
      <td align="center"><a href="publications.pl">出版物 (Publications)</a></td>


    </tr>
  </table>
END_HEREDOC
$page->footer();