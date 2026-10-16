use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('germinatingseed.html','html2pl converter');
$page->header('萌發種子基因庫 (Germinating Seed Library)');
print<<END_HEREDOC;

  <center>
    
    <table summary="" width="720" cellpadding="0" cellspacing="0"
    border="0">
      <tr>
        <td>
          <center>
            <h2>萌發種子基因庫 (Germinating Seed Library)</h2>
          </center>

          <table summary="" width="100\%" cellspacing="5">
            <tr valign="top">
              <td width="20\%">基因庫 (Library):</td>

              <td>cLEI</td>
            </tr>

            <tr valign="top">
              <td>TIGR 編號 (TIGR ID):</td>

              <td>TGS</td>
            </tr>

            <tr valign="top">
              <td>作者 (Authors):</td>

              <td>Alcala, Vrebalov, White, and Giovannoni</td>
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

              <td>whole seedlings</td>
            </tr>

            <tr valign="top">
              <td>發育階段 (Developmental stage):</td>

              <td>early germinating seedlings/cotyledons</td>
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

              <td>3.5 x 10<small><sup>5</sup></small></td>
            </tr>

            <tr valign="top">
              <td>大量切除數量 (Number mass excised):</td>

              <td>2.0 10<small><sup>5</sup></small></td>
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

              <td>Seedlings were collected seven days
              post-imbibition on water-agar. Mixed-stage, whole,
              germinating seedlings from seed coat emergence up to
              two centimeters in length were chosen. Seeds not
              showing obvious signs of germination were discarded.
              Tissue consists of germinating seedlings at various
              stages from 2 days imbibition to emergence
              (approximately four days) to 1 cm (approximately six
              days) to 2 cm (approximately 8 days). Tissues were
              harvested based on stage, not day.</td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    
  </center>
END_HEREDOC
$page->footer();