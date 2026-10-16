use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('maturegreenfruit.html','html2pl converter');
$page->header('成熟綠果基因庫 (Mature Green Fruit Library)');
print<<END_HEREDOC;

  <center>
    
    <table summary="" width="720" cellpadding="0" cellspacing="0"
    border="0">
      <tr>
        <td>
          <center>
            <h2>成熟綠果基因庫 (Mature Green Fruit Library)</h2>
          </center>

          <table summary="" width="100\%" cellspacing="5">
            <tr valign="top">
              <td width="20\%">基因庫 (Library):</td>

              <td>cLEF</td>
            </tr>

            <tr valign="top">
              <td>TIGR 編號 (TIGR ID):</td>

              <td>TMG</td>
            </tr>

            <tr valign="top">
              <td>作者 (Authors):</td>

              <td>Alcala, Vrebalov, White, and Giovannoni</td>
            </tr>

            <tr valign="top">
              <td>製作日期 (Date made):</td>

              <td>06/99</td>
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

              <td>fruit pericarp</td>
            </tr>

            <tr valign="top">
              <td>發育階段 (Developmental stage):</td>

              <td>mature green</td>
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

              <td>1.37 x 10<small><sup>6</sup></small></td>
            </tr>

            <tr valign="top">
              <td>大量切除數量 (Number mass excised):</td>

              <td>2.0 x 10<small><sup>5</sup></small></td>
            </tr>

            <tr valign="top">
              <td>平均插入片段長度 (Average insert length):</td>

              <td>1.6 Kb</td>
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

              <td>Fruit were tagged at the 1 cm stage and harvested
              3-5 days prior to ripening. Fruit were cut in half to
              verify the seeds were indeed "mature". The seeds and
              locules were discarded prior to freezing the
              pericarp. 09/14/99 cLEF - 83 total sequences,
              11dupes, 86.7\% unique with 32 unknowns. No junk found
              (chloroplast, mitochondria, or <em>E. coli</em>).</td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    
  </center>
END_HEREDOC
$page->footer();