use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new("Sol Genomics Network (SGN)","Tyler");
$page->header();
print <<END_HEREDOC;

     <br />
     <center>
     <table class="boxbgcolor2" width="100%" summary="">
     <tr>
     <td width="33%">&nbsp;</td>
     <td width="33%" class="left">
	  <div class="boxcontent">
	  <br />

	    <div class="subheading">
	    <u>SGN 資訊 (SGN Info)</u>
	    </div>
	    <div class="boxsubcontent">
              <a class="creativitylinks" href="/content/sgn_data.pl">SGN 資料概述 (SGN data overview)</a><br />
              <a class="creativitylinks" href="/about/index.pl">關於 SGN (More about SGN)</a><br />
              <a class="creativitylinks" href="/about/tomato_sequencing.pl">國際蕃茄定序計畫 (International tomato project)</a><br />
            </div>

            <div class="subheading">
            <u>茄科物種 (Solanaceous Species)</u>
            </div>
	    <div class="boxsubcontent">
	      <a class="creativitylinks" href="/content/sgn_data.pl#Solanumlycopersicum(formerlyLycopersiconesculentum)">蕃茄 (Tomato)</a><br />
              <a class="creativitylinks" href="/content/sgn_data.pl#Capsicumannuum">辣椒 (Pepper)</a><br />
	      <a class="creativitylinks" href="/content/sgn_data.pl#Solanumtuberosum">馬鈴薯 (Potato)</a><br />
	      <a class="creativitylinks" href="/content/sgn_data.pl#Solanummelongena">茄子 (Eggplant)</a><br />
	      <a class="creativitylinks" href="/content/sgn_data.pl#Petuniahybrida">矮牽牛 (Petunia)</a><br />
	      <a class="creativitylinks" href="/about/solanum_nomenclature.pl">茄屬命名法 (Solanum nomenclature)</a>
            </div>

	    <div class="subheading">
            <u>蕃茄基因體 (Tomato Genome)</u>
            </div>
            <div class="boxsubcontent">
              <a class="creativitylinks" href="/about/tomato_sequencing.pl">定序進度 (Sequencing progress)</a><br />
              <a class="creativitylinks" href="/search/direct_search.pl?search=BACs">搜尋 BAC (Search BACs)</a><br />
            </div>

            <div class="subheading">
            <u>圖譜與標記 (Maps and Markers)</u>
            </div>
	    <div class="boxsubcontent">
              <a class="creativitylinks" href="/cview/index.pl">可用圖譜 (Available maps)</a><br />
              <a class="creativitylinks" href="/search/direct_search.pl?search=Markers">搜尋標記 (Search markers)</a><br />
	      <a class="creativitylinks" href="/markers/cosii_markers.pl">關於 COSII 標記 (About COSII markers)</a><br />
	      <a class="creativitylinks" href="/markers/cosii.xls">最新 COSII 資料 (New COSII data)</a><br />
            </div>

	    <div class="subheading">
            <u>序列 (Sequences)</u>
            </div>
            <div class="boxsubcontent">
              <a class="creativitylinks" href="/search/direct_search.pl?search=EST">搜尋 EST (Search ESTs)</a><br />
              <a class="creativitylinks" href="/search/direct_search.pl?search=Unigene">搜尋單一基因 (Search unigenes)</a><br />
              <a class="creativitylinks" href="/search/library_search.pl?term=">cDNA 庫 (cDNA libraries)</a>
            </div>

            <div class="subheading">
            <u>工具 (Tools)</u>
            </div>
            <div class="boxsubcontent">
              <a class="creativitylinks" href="/tools/blast/">BLAST 比對</a><br />
              <a class="creativitylinks" href="/tools/intron_detection/find_introns.pl">內含子尋找工具 (Intron finder)</a><br />
            </div>

            <div class="subheading">
            <u>表型與突變體 (Phenotypes and Mutants)</u>
            </div>
            <div class="boxsubcontent">
              <a class="creativitylinks" href="/mutants/mutants_main.pl">突變體頁面 (Mutants page)</a>
            </div>

            <div class="subheading">
            <u>訂購 cDNA 選殖株 (Order cDNA clones)</u>
            </div>
            <div class="boxsubcontent">
              <a class="creativitylinks" href="/help/ordering/">訂購頁面 (Ordering page)</a>
            </div>
          </div>
</td>
<td width="33%">&nbsp;</td>
</tr>
</table>
</center>

END_HEREDOC

$page->footer();
