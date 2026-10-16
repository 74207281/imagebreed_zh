use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('Summer_Internship_2005.html','html2pl converter');
$page->header('2005 年暑期實習生 (2005 Summer Interns)');
print<<END_HEREDOC;

<div class="boxbgcolor2">

<h2 align="center">2005 年生物資訊暑期實習生 (2005 Bioinformatics Summer Interns)</h2>

<p>共有五位學生參加了我們透過美國國家科學基金會 (NSF) 資助專案「番茄真染色質定序與註解：茄科比較生物學架構 (Sequence and annotation of the tomato euchromatin: a framework for Solanaceae comparative biology)」(<a href="/about/tomato_project_overview.pl">專案詳情</a>) 提供的生物資訊暑期實習計畫。該實習計畫為大學生和高中生提供生物資訊培訓機會。以下為 2005 年暑期實習生的照片及其專案描述。有關實習資訊，請聯絡 Joyce Van Eck 博士 (jv\@cornell.edu)。(Five students participated in our Bioinformatics Summer Internship Program offered through the NSF-funded project. The internships provide opportunities in bioinformatics training for undergraduates and high school students. Below are photographs of the 2005 summer interns along with descriptions of their projects.)</p>

<br />

<table summary="">

<tr><td><center><strong>Adri Anna Mills</strong></center></td></tr>

<tr>
<td><a href="/static_content/sgn_photos/img/pic17_large.jpg"><img src="/static_content/sgn_photos/img/pic17_small.jpg" alt="" /></a></td>
<td>Adri 是紐約州伊薩卡康乃爾大學的大學生，雙主修計算生物學和動物科學。她在 Mueller 博士團隊中的專案是建立自動化工具來辨識 SGN 網站的問題。作為第二個專案，Adri 致力於在 SGN 實作 MOBY 服務 (http://www.biomoby.org/)。<br />(Adri is an undergraduate at Cornell University, Ithaca, NY with a dual major in Computational Biology and Animal Science. Her project in Dr. Mueller's group is to create automated tools to identify problems with the SGN website. As a second project, Adri works on implementing MOBY services at SGN.)</td>
</tr>

<tr><td>&nbsp;<br /></td></tr>

<tr><td><center><strong>Amarachukwu Enemuo</strong></center></td></tr>

<tr>
<td><a href="/static_content/sgn_photos/img/pic21_large.jpg"><img src="/static_content/sgn_photos/img/pic21_small.jpg" alt="" /></a></td>
<td>Amara 主修紐約市立學院計算機工程。她的專案在 Lukas Mueller 博士的團隊中，透過在標記詳細資訊頁面新增凝膠圖像來改善 SGN 功能。她在專案中使用了 SQL、Perl、網頁設計和圖像處理技術。<br />(Amara is majoring in Computer Engineering at The City College of New York, New York, NY. Her project is in Dr. Lukas Mueller's group, and she is improving SGN functionality by adding gel images to the marker detail pages. She is using SQL, Perl, web design, and image manipulation techniques in her project.)</td>
</tr>

<tr><td>&nbsp;<br /></td></tr>

<tr><td><center><strong>Benjamin Cole</strong></center></td></tr>

<tr>
<td><a href="/static_content/sgn_photos/img/ben_cole_large.jpg"><img src="/static_content/sgn_photos/img/ben_cole_small.jpg" alt="" /></a></td>
<td>Ben 是紐約州特洛伊倫斯勒理工學院生物資訊與分子生物學專業學生。他的實習在 Jim Giovannoni 博士的實驗室，導師為 Rob Alba 博士。Ben 正在進行與番茄色素沉著相關的專案，這是果實成熟的重要組成部分。<br />(Ben is a Bioinformatics and Molecular Biology major at Rensselaer Polytechnic Institute, Troy, NY. His internship is in Dr. Jim Giovannoni's lab, and Dr. Rob Alba is his project mentor. Ben is working on a project related to pigmentation in tomato, which is an important component of fruit ripening.)</td>
</tr>

<tr><td>&nbsp;<br /></td></tr>

<tr><td><center><strong>Caroline Nyenke</strong></center></td></tr>

<tr>
<td><a href="/static_content/sgn_photos/img/pic19_large.jpg"><img src="/static_content/sgn_photos/img/pic19_small.jpg" alt="" /></a></td>
<td>Caroline 在康乃爾大學主修生物科學，重點研究分子和細胞生物學。她在 Mueller 博士小組的專案涉及程式設計和網頁設計。她重新設計並實作了新的 SGN 工具列，並開發了用於番茄基因組定序專案數據的新批次下載工具。<br />(Caroline is majoring in Biological Science with an emphasis on molecular and cellular biology at Cornell University. Her project in Dr. Mueller's group involves programming and web design. She re-designed and implemented the new SGN toolbar, and developed a bulk download facility.)</td>
</tr>

<tr><td>&nbsp;<br /></td></tr>

<tr><td><center><strong>Tyler Simmons</strong></center></td></tr>

<tr>
<td><a href="/static_content/sgn_photos/img/pic18_large.jpg"><img src="/static_content/sgn_photos/img/pic18_small.jpg" alt="" /></a></td>
<td>Tyler 是紐約州紐瓦克瓦利高中的高中生。他也在 Mueller 博士的小組中，使用 HTML 和網頁設計為 SGN 網站製作網頁，並學習使用 Perl 進行程式設計。<br />(Tyler is a high school student from Newark Valley Senior High School in Newark Valley, NY. He is also in Dr. Mueller's group, and he is creating webpages for the SGN website using HTML and web design. He is actively learning to program using Perl.)</td>
</tr>

</table>

</div>
END_HEREDOC
$page->footer();
