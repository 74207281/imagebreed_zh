use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('Japan - Tomato Chromosome 8','Lukas');
$page->header('關於日本番茄定序計畫 (About the Japanese Tomato Sequencing Project)');
print<<END_HEREDOC;

  <center>

    <table summary="" width="720" cellpadding="10" cellspacing="5"
    border="0">
      <tr>
        <td><br />
        <img src="/documents/img/flags/Flag_of_Japan_small.png" border="1" alt=
        "flag of Japan" /></td>

        <td>
          <h1>番茄定序計畫 (Tomato Sequencing Project): 第 8 號染色體 (Chromosome 8)</h1>
          
          <h1>日本 (Japan)</h1>
          真染色質部分 (Euchromatin portion) = 17Mb<br />
          預估 BAC 數量 (Projected \# of BACs): 175<br /><br />
          <a href="tomato_sequencing.pl">點擊此處查看全部 12 條染色體總覽 (Click here for an overview of all 12 chromosomes)</a>
        </td>
      </tr>

      <tr>
        <td>&nbsp;</td>

        <td>
          <h4>計畫主持人 (Principal Investigators)</h4>
<ul>
<li><a href="http://www.kazusa.or.jp/eng/index.html">Daisuke Shibata, KDRI</a></li>
<li><a href="http://www.kazusa.or.jp/eng/index.html">Satoshi Tabata, KDRI</a></li>
</ul>
<h4>資助來源 (Funding)</h4>
<ul>
<li>千葉縣 (Chiba Prefecture)</li>
<li>上總 DNA 研究所基金會 (Kazusa DNA Research Institute Foundation)</li>
<li>蔬菜茶業研究所優先研究計畫 (National Institute of Vegetable and Tea Science (NIVTS) Priority Research Programme)</li>
</ul>

<h4>參與單位 (Participating Groups)</h4>
<ul>
<li><a href="http://www.kazusa.or.jp/eng/index.html">上總 DNA 研究所 (Kazusa DNA Research Institute)</a></li>
<li><a href="http://vegetea.naro.affrc.go.jp/index_en.html">蔬菜茶業研究所 (National Institute of Vegetable and Tea Science)</a></li>

        </td>
      </tr>
    </table>
  </center>
END_HEREDOC
$page->footer();
