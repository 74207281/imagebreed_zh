
use strict;
use utf8;

use CXGN::Page;
use CXGN::Page::FormattingHelpers qw | page_title_html |;

my $page = CXGN::Page->new();

$page->header('最新公告 (News & Announcements)');

my $title = page_title_html("中國將對番茄第 11 號染色體進行定序 (China to sequence tomato chromosome 11)");

print <<HTML;

<br /><br />
2007 年 9 月 17 日 (Sept 17, 2007)<br /><br />

<center>
<table width="600">
<tr><td>

<b>公告 (Announcement)</b>

$title

在第四屆國際 SOL 會議上，中國農業科學院蔬菜花卉研究所 (IVF-CAAS) 黃三文教授宣佈，中國將對番茄第 11 號染色體進行定序。<br /><br />該項承諾將由中國四家機構共同承擔：中國農業科學院蔬菜花卉研究所黃博士與杜永臣博士實驗室、華中農業大學葉志彪博士實驗室、中國農業大學楊文才博士實驗室以及華南農業大學王國平博士實驗室。IVF-CAAS 同時負責馬鈴薯第 10 和 11 號染色體的定序。<br /><br />將採用比較定序方法揭示馬鈴薯與番茄第 11 號染色體真染色質部分的相似性與分化。中國農業部正以種子基金支持該倡議。<br /><br />
<span style="color:#555">(At the 4th International SOL conference, Prof Sanwen Huang from the Institute of Vegetables and Flowers, Chinese Academy of Agricultural Sciences (IVF-CAAS) announced that China will sequence tomato chromosome 11. The commitment will be a joint effort of four institutions in China: IVF-CAAS, Huazhong Agricultural University, China Agricultural University, and South China Agricultural University. IVF-CAAS is also responsible for the sequencing of potato chromosome 10 and 11.)</span>

</td></tr></table>
</center>


<br /><br />

HTML

$page->footer();
