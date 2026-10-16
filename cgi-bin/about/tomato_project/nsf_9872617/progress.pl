use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('progress.html','html2pl converter');
$page->header('番茄 EST 進度報告 (Tomato EST Progress Reports)');
print<<END_HEREDOC;

  <h2>進度會議 (Progress Meetings)</h2>

  <p>番茄基因組計畫小組在 2000 年 3 月 6 日番茄基因組計畫<a href="/documents/help/about/tomato_project/NSF.Figures.pdf">第一次進度會議</a>和 2000 年 6 月 5 日<a href="/documents/help/about/tomato_project/NSF.genomics.II.pdf">第二次進度會議</a>上展示的圖表均以 PDF 文件形式提供。這些文件總結了番茄微陣列技術開發以及擬南芥與番茄之間同線性發現的進展。<br />
  (Figures as presented by the Tomato Genome Project group during the first progress meeting on March 6, 2000 and the second progress meeting on June 5, 2000 are available as pdf files.)</p>

  <hr />

  <h2>EST 定序進度 (Progress of EST Sequencing)</h2>

  <p>最後更新日期 (Last updated): 2000-06-19</p>

  <p>下表概述了已發送至 TIGR 進行定序的 cDNA 基因庫，以及迄今為止每個基因庫成功定序的 EST 數量。(The following table outlines the cDNA libraries that have been sent to TIGR for sequencing and the number of successfully sequenced ESTs produced from each to date.)</p>

  <table summary="" align="center" border="1" width="90\%"
  cellpadding="5" cellspacing="2">
    <tr>
      <td align="center" valign="middle">
        <h3><strong>基因庫組織<br />(Library Tissue)</strong></h3>
      </td>

      <td align="center" valign="middle">
        <h3><strong>物種<br />(Species)</strong></h3>
      </td>

      <td align="center" valign="middle">
        <h3><strong>康乃爾代號<br />(Cornell ID)</strong></h3>
      </td>

      <td align="center" valign="middle">
        <h3><strong>TIGR 代號<br />(TIGR ID)</strong></h3>
      </td>

      <td align="center" valign="middle">
        <h3><strong>成功定序 EST 數量<br />(Number of Successfully Sequenced ESTs)</strong></h3>
      </td>

      <td align="center" valign="middle">
        <h3><strong>定序狀態<br />(Sequencing Status)</strong></h3>
      </td>
    </tr>

    <tr>
      <td><a href="/content/libraries/shoot.pl">Shoot</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEB</td>

      <td align="center">TSH</td>

      <td align="center">1,348</td>

      <td align="center">On Hold</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/callus.pl">Callus</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEC</td>

      <td align="center">TCA</td>

      <td align="center">10,072</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/ovary.pl">Ovary</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLED</td>

      <td align="center">TOV</td>

      <td align="center">10,222</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/quiescentseed.pl">Quiescent seed</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEE</td>

      <td align="center">TSE</td>

      <td align="center">778</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href=
      "/content/libraries/germinatingseed.pl">Germinating
      seed</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEI</td>

      <td align="center">TGS</td>

      <td align="center">4,262</td>

      <td align="center">Sequencing</td>
    </tr>

    <tr>
      <td><a href=
      "/content/libraries/developingfruit.pl">Immature green
      fruit</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEM</td>

      <td align="center">TOM</td>

      <td align="center">74</td>

      <td align="center">Sequencing</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/maturegreenfruit.pl">Mature
      green fruit</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEF</td>

      <td align="center">TMG</td>

      <td align="center">5,582</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/breakerfruit.pl">Breaker fruit</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEG-R</td>

      <td align="center">TBF</td>

      <td align="center">2,096</td>

      <td align="center">Sequencing</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/tomatoredripe.pl">Red, ripe
      fruit</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEN</td>

      <td align="center">TRR</td>

      <td align="center">4,196</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href=
      "/content/libraries/pseudomonasresponse.pl">Leaves from
      <em>Pseudomonas</em> resistant variety</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLER</td>

      <td align="center">TPR</td>

      <td align="center">5,413</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href=
      "/content/libraries/pseudomonasresponse_s.pl">Leaves from
      <em>Pseudomonas</em> susceptible variety</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLES</td>

      <td align="center">TPS</td>

      <td align="center">5,966</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/mixedelicitor.pl">Leaf
      tissue under mixed elicitor stress</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLET</td>

      <td align="center">TME</td>

      <td align="center">11,912</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/deficientroot.pl">Roots
      under mixed mineral deficiencies and stresses</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEW</td>

      <td align="center">TRD</td>

      <td align="center">2,151</td>

      <td align="center">Sequencing</td>
    </tr>

    <tr>
      <td><a href=
      "/content/libraries/rootsatvegetative.pl">Pre-anthesis
      roots</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEY</td>

      <td align="center">TRY</td>

      <td align="center">2,646</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href=
      "/content/libraries/rootatfruitset.pl">Post-anthesis
      roots</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEX</td>

      <td align="center">TRX</td>

      <td align="center">3,312</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/rootlibraries.pl">Roots
      from germinating seedlings</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cLEZ</td>

      <td align="center">TRZ</td>

      <td align="center">2,519</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href=
      "/content/libraries/hirsutumtrichome.pl">Trichomes</a></td>

      <td>Lycopersicon hirsutum</td>

      <td align="center">cLHT</td>

      <td align="center">THT</td>

      <td align="center">2,627</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href=
      "/content/libraries/pennelliitrichome.pl">Trichomes</a></td>

      <td>Lycopersicon pennellii</td>

      <td align="center">cLPT</td>

      <td align="center">TPT</td>

      <td align="center">3,009</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/flowerbudctoa.pl">0-3mm
      flower buds</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cTOA</td>

      <td align="center">TFA</td>

      <td align="center">2,612</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/flowerbudctob.pl">3-8mm
      flower buds</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cTOB</td>

      <td align="center">TFB</td>

      <td align="center">2,713</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/flowerbudctoc.pl">8mm to
      pre-anthesis flower buds</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cTOC</td>

      <td align="center">TFC</td>

      <td align="center">2,761</td>

      <td align="center">Completed</td>
    </tr>

    <tr>
      <td><a href="/content/libraries/openflowerctod.pl">Open
      flowers</a></td>

      <td>Lycopersicon esculentum</td>

      <td align="center">cTOD</td>

      <td align="center">TFD</td>

      <td align="center">2,952</td>

      <td align="center">Completed</td>
    </tr>
  </table><br />

  <p>For more information on specific sequences please visit
  <a href="/">The Solanaceae Genome
  Network</a>.</p>

    

END_HEREDOC
$page->footer();
