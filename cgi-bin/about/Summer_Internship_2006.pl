use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('Summer_Internship_2006.html','Lukas');
$page->header('2006 年暑期實習生 (2006 Summer Interns)');
print<<END_HEREDOC;

<div class="boxbgcolor2">

<h2 align="center">2006 年生物資訊暑期實習生 (2006 Bioinformatics Summer Interns)</h2>

<p>共有四位學生參加了我們透過美國國家科學基金會 (NSF) 資助專案「番茄真染色質定序與註解：茄科比較生物學架構 (Sequence and annotation of the tomato euchromatin: a framework for Solanaceae comparative biology)」(<a href="/about/tomato_project_overview.pl">專案詳情</a>) 提供的生物資訊暑期實習計畫。該實習計畫為大學生和高中生提供生物資訊培訓機會。以下為 2006 年暑期實習生照片及其專案描述。有關實習資訊，請聯絡 Joyce Van Eck 博士 (jv\@cornell.edu)。(Four students participated in our Bioinformatics Summer Internship Program offered through the NSF-funded project. The internships provide opportunities in bioinformatics training for undergraduates and high school students. Below are photographs of the 2006 summer interns along with descriptions of their projects.)</p>

<br />

<table summary="">

<tr><td><strong>Scott Bland</strong></td></tr>

<tr>
<td>
Scott Bland 是伊薩卡高中的高中生。在實習期間，他編寫了用於 SGN 網站的 Perl 程式，並研究了從基因樹預測直系同源性的方法。目前他是史丹佛大學的大學生。<br />(Scott Bland is a high school student at Ithaca High School. During his internship, he created Perl programs for use on the SGN website and worked on methods to predict orthology from gene trees. Currently, he is an undergraduate at Stanford University.)
</td>
</tr>

<tr><td>&nbsp;<br /></td></tr>

<tr><td><strong>Johnathon Schwarz</strong></td></tr>

<tr>
<td>Johnathon 是伊薩卡高中的高中生。他修改了 SGN 登入系統以使用資料庫後端，執行了預測 SolCyc 生化途徑資料庫的初始分析，並安裝了自動監控 SGN 伺服器的系統。<br />(Johnathon is a high school student at Ithaca High. He modified the SGN login system to use a database backend, ran the initial analyses to predict the SolCyc biochemical pathway databases, and installed a system to automatically monitor the SGN servers.)
</td>
</tr>

<tr><td>&nbsp;<br /></td></tr>

<tr><td><strong>Emily Hart</strong></td></tr>

<tr>
<td>Emily 使用 Perl 和關聯式資料庫為 SGN 網站實作了多種工具。目前她是卡內基美隆大學的大學生。<br />(Emily implemented several tools for the SGN website using Perl and relational databases. Currently, she is an undergraduate at Carnegie Mellon University.)
</td>
</tr>

<tr><td><br /><strong>Adri Mills</strong></td></tr>

<tr>
<td>Adri 是 2005 年的資深實習生，她非常喜歡第一次實習，因此再次參與！她開發了 BLASTWatch 等功能，允許使用者提交序列，系統每週將其與最新番茄序列進行 BLAST 比對並透過電子郵件提醒使用者新比對結果。目前 Adri 擔任 SGN 程式設計師。<br />(Adri, a veteran intern from 2005, liked the first internship so much she came back for a second one! She worked on features such as BLASTWatch, which lets users submit sequences which are then BLASTed once a week against the emerging tomato sequence and the users are alerted of new matches by email. Currently, Adri works as a programmer at SGN.)
</td>
</tr>

<tr><td>&nbsp;<br /></td></tr>

<tr><td>
<center>
<img src="/static_content/sgn_photos/interns_2006/2006_summer_interns.jpg" />
<br />

<table><tr><td width="300">
2006 年暑期實習生（從右至左）：Johnathon Schwartz、Emily Hart 與 Scott Bland（Adri 未入鏡）。<br />(The summer interns of the 2006 vintage: frtl: Johnathon Schwartz, Emily Hart and Scott Bland (Adri not pictured).)
</td></tr></table>
</center>

</td></tr>
</table>

</div>
END_HEREDOC
$page->footer();
