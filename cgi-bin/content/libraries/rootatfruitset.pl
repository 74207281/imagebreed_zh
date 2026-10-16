use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('rootatfruitset.html','html2pl converter');
$page->header('開花後根系基因庫 (Post-anthesis Root Library)');
print<<END_HEREDOC;

  <center>
    
    <table summary="" width="720" cellpadding="0" cellspacing="0"
    border="0">
      <tr>
        <td>
          <center>
            <h2>開花後根系基因庫 (Post-anthesis Root Library)</h2>
          </center>

          <table summary="" width="100\%" cellspacing="5">
            <tr valign="top">
              <td width="20\%">基因庫 (Library):</td>

              <td>cLEX</td>
            </tr>

            <tr valign="top">
              <td>TIGR 編號 (TIGR ID):</td>

              <td>TRX</td>
            </tr>

            <tr valign="top">
              <td>作者 (Authors):</td>

              <td>Rutger van der Hoeven, Dave Garvin, Leon Kochian,
              and Steve Tanksley</td>
            </tr>

            <tr valign="top">
              <td>製作日期 (Date made):</td>

              <td>07/99</td>
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

              <td>root</td>
            </tr>

            <tr valign="top">
              <td>發育階段 (Developmental stage):</td>

              <td>roots from plants at fruit-set stage/post-fruit
              loading roots</td>
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

              <td>1.0 x 10<small><sup>7</sup></small></td>
            </tr>

            <tr valign="top">
              <td>大量切除數量 (Number mass excised):</td>

              <td>1.5 x 10<small><sup>6</sup></small></td>
            </tr>

            <tr valign="top">
              <td>平均插入片段長度 (Average insert length):</td>

              <td>0.9 Kb</td>
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

              <td>Tissue supplied by Dave Garvin (USDA-ARS, Ithaca,
              NY, 14850) and Leon Kochian.</td>
            </tr>
          </table>
        </td>
      </tr>
</table>
    
  </center>
END_HEREDOC
$page->footer();