use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('italy.html','html2pl converter');
$page->header('關於義大利定序計畫 (About the Italian Sequencing Project)');
print<<END_HEREDOC;

  <center>

    <table summary="" width="720" cellpadding="10" cellspacing="10"
    border="0">
      <tr>
        <td><br />
        <img src="/documents/img/flags/italy_big.gif" border="0" alt=
        "Italian flag" /></td>

        <td>
          <h1>番茄定序計畫 (Tomato Sequencing Project):</h1>
          <br />
          <h1>第 12 號染色體 (Chromosome 12)</h1>
          <p>真染色質部分 (Euchromatin portion) = 11Mb<br />
          預估 BAC 數量 (Projected # of BACs): 113<br />
          <a href=
          "tomato_sequencing.pl">
          全部 12 條染色體總覽 (Overview of all 12 chromosomes)</a></p>
        </td>
      </tr>

      <tr>
        <td>&nbsp;</td>

        <td>
          <h4>計畫主持人 (Principal Investigators)</h4>
          <p>Prof. Luigi Frusciante,
          University of Naples<br />
          Dr. Giovanni Giuliano, ENEA</p>

          <h4>資助來源 (Funding)</h4>
          <p><a href=
          "http://agronanotech.unina.it/index.php?id=35">Agronanotech
          project</a> (Italian Ministry of Agriculture)<br />
          <a href="http://www.enea.it">ENEA</a> (Italian Agency for
          New technologies, Energy and the Environment)</p>

          <h4>合作者 (Collaborators)</h4>
          <p>Dr. Silvana Grandillo, Italian
          Research Council<br />
          Prof. Giorgio Valle, University of Padua</p>
        </td>
      </tr>
    </table>
  </center>
END_HEREDOC
$page->footer();