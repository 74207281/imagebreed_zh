use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('breakerfruit.html','html2pl converter');
$page->header('轉色期果實基因庫 (Breaker Fruit Library)');
print<<END_HEREDOC;

  <center>
    

    <table summary="" width="720" cellpadding="0" cellspacing="0"
    border="0">
      <tr>
        <td>
          <center>
            <h2>轉色期果實 (Breaker fruit)</h2>
          </center>

          <table summary="" width="100\%" cellspacing="5">
            <tr valign="top">
              <td width="20\%">基因庫 (Library):</td>

              <td>cLEG-R</td>
            </tr>

            <tr valign="top">
              <td>TIGR 編號 (TIGR ID):</td>

              <td>TBF</td>
            </tr>

            <tr valign="top">
              <td>作者 (Authors):</td>

              <td>Alcala, White, and Giovannoni</td>
            </tr>

            <tr valign="top">
              <td>製作日期 (Date made):</td>

              <td>02/00</td>
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

              <td>breaker</td>
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

              <td>6.6 x 10<small><sup>5</sup></small></td>
            </tr>

            <tr valign="top">
              <td>大量切除數量 (Number mass excised):</td>

              <td>3.0 10<small><sup>5</sup></small></td>
            </tr>

            <tr valign="top">
              <td>平均插入片段長度 (Average insert length):</td>

              <td>1.4 Kb</td>
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

              <td>Fruit were harvested at the "breaker" stage
              (first sign of lycopene accumulation on the blossom
              end of the fruit). Fruit were cut in half and the
              seeds and locules were discarded prior to freezing
              the pericarp.</td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    
  </center>
END_HEREDOC
$page->footer();