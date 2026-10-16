
use strict;
use utf8;

use CXGN::Page;
use CXGN::Page::FormattingHelpers qw | page_title_html |;

my $page = CXGN::Page->new();

$page->header('SGN 公告 (SGN Announcement)');

my $title = page_title_html("公告 (Announcement)");

print <<HTML;

$title

<h1>2009 年 10 月 30 日 (October 30, 2009)</h1>

<h2>全新番茄 SNaPshot 物理圖譜現已發布 (New SNaPshot Physical Map of Tomato Available)</h2>

<table width="75%" align="center" alt="Tomato FPC build announcement"><tr><td>
<p>我們很高興地宣布，全新的番茄物理圖譜已建立並全面向公眾發布，以協助完成國際番茄基因組定序工作，並廣泛推動番茄的公私立研究。該圖譜約代表番茄基因組 10 倍 BAC 覆蓋度，並利用了來自四個獨立 BAC 文庫（HindIII、EcoRI 和 MboI 基因組部分消化文庫以及剪切基因組文庫）的選殖株。可透過 SGN 物理圖譜連結 (<a href="http://solgenomics.net">http://solgenomics.net/</a>) 訪問該圖譜，並可從我們的 FTP 站點 (<a href="ftp://ftp.solgenomics.net">ftp://ftp.solgenomics.net/</a>) 獲取完整組裝。我們正在新增一組小型的額外錨定 BAC，然後將進行手動編輯以改善圖譜。更新將在 SGN 上進行並宣布。該圖譜和所有底層 BAC 選殖株均無限制地向公眾開放。我們鼓勵您使用這項新資源並提供寶貴意見。<br />
(We are pleased to announce the creation and full public release of a new physical map of tomato to assist in completion of the international tomato genome sequencing effort and to broadly promote public and private research on tomato. This map represents approximately 10X BAC coverage of the tomato genome...)</p>

<p>該圖譜由<a href="http://www.genome.arizona.edu">亞利桑那基因組研究所 (Arizona Genomics Institute)</a> 在<a href="http://www.nsf.gov/">美國國家科學基金會 (NSF)</a> 資助下建立（植物基因組計畫補助金 <a href="http://www.nsf.gov/awardsearch/showAward.do?AwardNumber=08-20612">08-20612</a> 授予<a href="http://bti.cornell.edu/">博伊斯湯普森植物研究所 (Boyce Thompson Institute for Plant Research)</a>）。四個底層 BAC 文庫也是使用 NSF 資金建立的（植物基因組計畫補助金 <a href="http://www.nsf.gov/awardsearch/showAward.do?AwardNumber=06-05659">06-05659</a>），剪切 BAC 文庫則是與 <a href="http://www.eu-sol.net">EU-SOL 聯盟</a> (FOOD-CT-2006-016214) 共同合作完成。<br />
(The map was created by the Arizona Genomics Institute with funding from the United States National Science Foundation...)</p>

<p>如需更多資訊，請聯絡 <a href="mailto:sgn-feedback\@solgenomics.net">SGN</a>。(Please contact SGN for more information.)</p>

</td></tr></table>

HTML

$page->footer();
