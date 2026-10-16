use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('Spain - Tomato Chromosome 9','Lukas');
$page->header('關於西班牙番茄定序計畫 (About the Spanish Tomato Sequencing Project)');
print<<END_HEREDOC;

  <center>

    <table summary="" width="720" cellpadding="10" cellspacing="5"
    border="0">
      <tr>
        <td><br />
        <img src="/documents/img/flags/Flag_of_Spain_small.png" border="0" alt=
        "Flag of Spain" /></td>

        <td>
          <h1>番茄定序計畫 (Tomato Sequencing Project): 第 9 號染色體 (Chromosome 9)</h1>
          
          <h1>西班牙 (Spain)</h1>
          真染色質部分 (Euchromatin portion) = 16 Mb<br />
          預估 BAC 數量 (Projected \# of BACs): 164<br /><br />
          <a href="tomato_sequencing.pl">點擊此處查看全部 12 條染色體總覽 (Click here for an overview of all 12 chromosomes)</a>
        </td>
      </tr>

      <tr>
        <td>&nbsp;</td>

        <td>
          <h4>計畫主持人 (Principal Investigators)</h4>

    Antonio Granell, <a href="http://www.ibmcp.upv.es/">IBMCP, Valencia</a><br />
    Miguel A. Botella, <a href="http://www.uma.es">UMA, Malaga</a><br />

          <h4>資助來源 (Funding)</h4>
          <p><a href="http://www.gen-es.org">Genoma Espana</a></p>

<h4>參與單位 (Participating Groups)</h4>

<a href="http://www.ibmcp.upv.es/">IBMCP-Valencia, CSIC</a><br />
<a href="http://evolutionarygenomics.imim.es/research_lines.html">IMIM-Barcelona</a><br />
<a href="http://www.sistemasgenomicos.com/general/">Sistemas Genomicos</a><br />

        </td>
      </tr>
    </table>
  </center>
END_HEREDOC
$page->footer();
