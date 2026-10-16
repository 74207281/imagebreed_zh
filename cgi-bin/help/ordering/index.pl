use strict;
use warnings;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('SGN: 訂購選殖株 (Ordering Clones)');
print<<END_HEREDOC;

  <center>
    

    <table summary="" width="720" cellpadding="0" cellspacing="0"
    border="0">
      <tr>
        <td>
          <h4>訂購選殖株 (Ordering Clones)</h4>

          <div class="boxcontent">
            <dl>
              <dt><strong>番茄 (Tomato)</strong></dt>

              <dd>由康乃爾大學 <a href=
              "http://ted.bti.cornell.edu/">TED BTI</a> <a href=
              "http://ted.bti.cornell.edu/cgi-bin/TFGD/order/home.cgi">購買番茄 EST 或 BAC 選殖株 (Purchase tomato EST or BAC clones)</a>。</dd>

              <dt><br /><strong>馬鈴薯 (Potato)</strong></dt>

              <dd>由 <a href=
              "http://www.genome.arizona.edu/">Arizona Genome
              Initiative</a> <a href=
              "http://www.genome.arizona.edu/orders/">購買馬鈴薯選殖株 (Purchase potato clones)</a>。</dd>

              <dt><br /><strong>辣椒 (Pepper)</strong></dt>

              <dd>如需辣椒選殖株，請聯絡韓國 KRIBB 的 <a href=
              "/solpeople/personal-info.pl?sp_person_id=87">
              Doil Choi</a>。</dd>
            </dl>
          </div>
        </td>
      </tr>
    </table>
    
  </center>
END_HEREDOC
$page->footer();

