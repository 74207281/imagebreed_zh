use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('quiescentseed.html','html2pl converter');
$page->header('休眠種子基因庫 (Quiescent Seed Library)');
print<<END_HEREDOC;

  <center>
    
    <table summary="" width="720" cellpadding="0" cellspacing="0"
    border="0">
      <tr>
        <td>
          <center>
            <h2>休眠種子基因庫 (Quiescent Seed Library)</h2>
          </center>

          <table summary="" width="100\%" cellspacing="5">
            <tr valign="top">
              <td width="20\%">基因庫 (Library):</td>

              <td>cLEE</td>
            </tr>

            <tr valign="top">
              <td>TIGR 編號 (TIGR ID):</td>

              <td>TSE</td>
            </tr>

            <tr valign="top">
              <td>作者 (Authors):</td>

              <td>Alcala, Vrebalov, White, and Giovannoni</td>
            </tr>

            <tr valign="top">
              <td>製作日期 (Date made):</td>

              <td>12/99</td>
            </tr>

            <tr valign="top">
              <td>物種 (Species):</td>

              <td><em>Lycopersicon esculentum</em></td>
            </tr>

            <tr valign="top">
              <td>品系/材料 (Accession):</td>

              <td>TA496</td>
            </tr>

            <tr valign="top">
              <td>組織 (Tissue):</td>

              <td>seeds</td>
            </tr>

            <tr valign="top">
              <td>發育階段 (Developmental stage):</td>

              <td>dissected five days post-anthesis to fruit
              over-ripe stage</td>
            </tr>

            <tr valign="top">
              <td>載體 (Vector):</td>

              <td>pBluescript SK(+/-)</td>
            </tr>

            <tr valign="top">
              <td>宿主 (Host):</td>

              <td>SOLR</td>
            </tr>

            <tr valign="top">
              <td>初級 pfu (Primary pfu):</td>

              <td>1.2 x 10<small><sup>4</sup></small></td>
            </tr>

            <tr valign="top">
              <td>大量切除數量 (Number mass excised):</td>

              <td>1.2 x 10<small><sup>4</sup></small></td>
            </tr>

            <tr valign="top">
              <td>平均插入片段長度 (Average insert length):</td>

              <td>1.0 Kb</td>
            </tr>

            <tr valign="top">
              <td>選殖位點 (Cloning sites):</td>

              <td>5' EcoRI, 3' XhoI</td>
            </tr>

            <tr valign="top">
              <td>抗生素 (Antibiotic):</td>

              <td>ampicillin</td>
            </tr>

            <tr valign="top">
              <td>引子 (Primers):</td>

              <td>M13F and M13R</td>
            </tr>

            <tr valign="top">
              <td>備註 (Comments):</td>

              <td>All of the primary library was mass excised.
              Tissue is from seed and maturing carpels. Fruit from
              5 dpa, 10 dpa, 20 dpa, mature green, breaker, firm,
              red-ripe, and very soft, red-ripe were collected.
              Seed was removed from all stages, though there was
              relatively little from the 5 dpa stage. 0.1 g of 5
              dpa seed was combined with 0.3 g of 10 dpa, 0.7 g of
              20 dpa, and 0.3 g from each of the mature green
              through late ripening stage seeds (1.2 g total for
              these 4) for RNA extraction.</td>
            </tr>
          </table>
        </td>
      </tr>
</table>
    
  </center>
END_HEREDOC
$page->footer();