use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('Summer_Internship_2007.html','html2pl converter');
$page->header('2007 年暑期實習生 (2007 Summer Interns)');
print<<END_HEREDOC;

<div class="boxbgcolor2">

<h2 align="center">2007 年生物資訊暑期實習生 (2007 Bioinformatics Summer Interns)</h2>

<p>共有四位學生參加了我們透過美國國家科學基金會 (NSF) 資助專案「番茄真染色質定序與註解：茄科比較生物學架構 (Sequence and annotation of the tomato euchromatin: a framework for Solanaceae comparative biology)」(<a href="/about/tomato_project_overview.pl">專案詳情</a>) 提供的生物資訊暑期實習計畫。該實習計畫為大學生和高中生提供生物資訊培訓機會。以下為 2007 年暑期實習生照片及其專案描述。有關實習資訊，請聯絡 Joyce Van Eck 博士 (jv\@cornell.edu)。(Four students participated in our Bioinformatics Summer Internship Program offered through the NSF-funded project. The internships provide opportunities in bioinformatics training for undergraduates and high school students. Below are photographs of the 2007 summer interns along with descriptions of their projects.)</p>

<br />

<table summary="">


<tr><td><strong>Jessica Reuter</strong></td></tr>

<tr>
<td><img src="/static_content/sgn_photos/interns_2007/jessica_reuter.jpg" /></td>
<td>Jessica Reuter 是羅徹斯特理工學院生物資訊學學生。在實習期間，她建立了 SGN 圖像搜尋功能，為 SGN 網站實作了基於 AJAX 的本體瀏覽器，開發了伺服器端 Perl 程式和瀏覽器端 JavaScript 技術，並設計了過程中使用的 XML 文件格式。<br />(Jessica Reuter is a bioinformatics student at Rochester Institute of Technology. During her internship, she created the SGN Image search, implemented an AJAX based ontology browser for the SGN website, where she developed both server end Perl programs and browser side JavaScript techniques, and designed XML documents formats used in the process.)</td>
</tr>

<tr><td><br /><strong>Alexander Naydich</strong></td></tr>


<td width="220"><img src="/static_content/sgn_photos/interns_2007/sasha_naydich.jpg" /></td>
<td>
Alexander Naydich 是伊薩卡高中的高中生。在實習期間，他重構了物件導向 Perl 程式碼並為批次下載公用程式新增了功能。在第二個專案中，他研究了利用 SGN 資料庫中儲存的文獻資料進行自動知識提取，以對茄科基因位點進行自動註解。<br />(Alexander Naydich is a high school student at Ithaca High School. During his internship, he refactored object oriented Perl code and added features to the bulk download utility. In his second project, he worked on automatic annotation of Solanaceae gene loci using automated knowledge extraction from the literature data stored in the SGN database.)
</td>
</tr>

<tr><td><br /><strong>Matthew Crumb</strong></td></tr>

<tr>
<td><img src="/static_content/sgn_photos/interns_2007/matthew_crumb.jpg" /></td>
<td>Matthew Crumb 是伊薩卡高中的高中生。在實習期間，他重構了物件導向 Perl 程式碼並為批次下載公用程式新增了功能。在第二個專案中，他研究了利用 SGN 資料庫中儲存的文獻資料進行自動知識提取，以對茄科基因位點進行自動註解。<br />(Matthew Crumb is a high school student at Ithaca High School. During his internship, he refactored object oriented Perl code and added features to the bulk download utility. In his second project, he worked on automatic annotation of Solanaceae gene loci using automated knowledge extraction from the literature data stored in the SGN database.)
</td>
</tr>

<tr><td><br /><strong>Tim Jacobs</strong></td></tr>

<tr>
<td><img src="/static_content/sgn_photos/interns_2007/tim_jacobs.jpg" /></td>
<td>Tim Jacobs 是水牛城大學的大學生，在 SGN 網站上實作了基於 AJAX 的功能，為已登入使用者提供易於使用的介面來關聯不同資料類型。他還實作了位點註冊資料庫的 AJAX 部分。<br />(Tim Jacobs is an undergraduate at University of Buffalo and implemented AJAX-based functionalities on the SGN website, dealing with associating different datatypes to each other using easy to use user interfaces for logged in users. He also implemented the AJAX aspects of the locus registry database.)
</td>
</tr>


<tr><td>&nbsp;<br /></td></tr>


<tr><td>&nbsp;<br /></td></tr>


</table>

</div>
END_HEREDOC
$page->footer();
