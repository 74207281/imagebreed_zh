use strict;
use warnings;
use utf8;
use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/info_section_html info_table_html columnar_table_html/;
my $page=CXGN::Page->new('us_tomato_sequencing.html','html2pl converter');
$page->header(('關於美國番茄定序專案(About the US Tomato Sequencing Project)') x 2);

print <<EOH;
EOH

print info_section_html( title => '計畫主持人(Principal Investigators)',
			 contents =>
			 info_table_html(__border => 0,
					 '專案 PIs(Project PIs)' =>
					 columnar_table_html( headings => ['計畫主持人(PI)','聯絡方式(Contact)','所屬機構(Organization)'],
							      data =>
							      [
								['Jim Giovannoni','jjg33@cornell.edu','Boyce Thompson Institute for Plant Research (BTI)'],
								['Bruce Roe', 'broe@ou.edu', 'University of Oklahoma'],
								['Lukas Mueller','lam87@cornell.edu','Boyce Thompson Institute for Plant Research (BTI)'],
								['Stephen Stack','sstack@lamar.colostate.edu','Colorado State University'],
								['Joyce Van Eck','jv27@cornell.edu','Boyce Thompson Institute for Plant Research (BTI)'],
							      ],
							    ),
					 '專案經理與教育推廣協調員(Project Manager and Educational Outreach Coordinator)' => <<EOH,
          <p>Joyce Van Eck<br />
          The Boyce Thompson Institute for Plant Research<br />
          Tower Rd.<br />
          Ithaca, NY 14853-1801<br />
          USA<br />
          電子郵件(e-mail): <a href="mailto:jv27\@cornell.edu">jv27\@cornell.edu</a><br />
          電話(Phone): 607-254-1284<br />
          傳真(Fax): 607-254-1284</p>
EOH
					 '資助來源(Funding)' => <<EOH,
          美國專案由<a href="http://www.nsf.gov">美國國家科學基金會 (National Science Foundation)</a>植物基因組研究計畫資助，補助編號為 <a href="http://www.nsf.gov/awardsearch/showAward.do?AwardNumber=0421634">#0421634</a>。(The US Project is funded by the National Science Foundation, Plant Genome Research Program, Grant #0421634.)
EOH
					),
		       );

print info_section_html( title => '計畫摘要(Project Summary)',
			 contents => <<EOH,

       <h4>科學目標與方法(Scientific objectives and approaches)</h4>

          <p>番茄基因組大約由 950 Mb 的 DNA 組成，其中超過 75% 為異染色質且基本上缺乏基因。大多數基因位於每條染色體臂末端區域長片段連續且富含基因的真染色質中。作為國際聯盟的一部分，番茄基因組的這些富含基因區域將使用最小平鋪路徑 (minimal tiling path) 方法進行定序。美國專案旨在透過建立額外的 2 個 BAC 文庫、獲取 BAC 末端序列（400,000 次讀取）以及對剪切文庫進行定序，為定序奠定基礎。Sol Genomics Network (<a href="/">SGN</a>) 作為致力於茄科物種基因組學的生物資料庫，將擴展以容納並整合所有 12 條番茄染色體的定序、註解和製圖資訊，並透過一系列共享通用軟體和演算法將 SGN 與其他資料庫整合，以建立植物基因組資訊網路。目前，美國在後續專案中已被分配負責染色體 1、10 和 11 的完整定序。(The tomato genome is comprised of approximately 950 Mb of DNA -- more than 75% of which is heterochromatin and largely devoid of genes... Currently, the US has been assigned chromsomes 1, 10 and 11 for full sequencing in a follow-up project.)</p>

        <h4>專案的更廣泛影響(Broader impact of the project)</h4>

          <p>番茄基因組定序是一項更大國際合作「國際茄科基因組計畫 (The International Solanaceae Genome Project)」的基石。其目標是建立一個資訊、資源與科學家網路，以解決植物生物學/農業中最重大的兩個問題：(Sequencing the tomato genome is the cornerstone of a larger international effort: "The International Solanaceae Genome Project".)</p>
          <ol>
          <li>一組共同的基因/蛋白質如何促成佔據我們星球的各種形態與生態上獨特的生物？(How can a common set of genes/proteins give rise to a wide range of morphologically and ecologically distinct organisms that occupy our planet?)</li>
          <li>如何利用對植物多樣性遺傳基礎的更深入理解，以環保且永續的方式更好地滿足社會需求？(How can a deeper understanding of the genetic basis of plant diversity be harnessed to better meet the needs of society in an environmentally-friendly and sustainable manner?)</li>
          </ol>
          <p>茄科非常適合回答這兩個問題。由於番茄基因組透過比較遺傳圖譜與其他茄科物種相連，且在基因含量與順序方面的微共線性似乎高度保守，因此將番茄基因組序列立即應用於其他茄科物種是可行的。最後，由於茄科代表了與擬南芥、紫花苜蓿和水稻相距甚遠的獨特且分化的有花植物分支，番茄基因組序列將為研究長時間演化歷程中基因與基因組演化的動力提供豐富資源。(The family Solanaceae is ideally suited to answer both of these questions...)</p>
EOH
		       );

print info_section_html(title => '教育推廣(Educational Outreach)',
			contents => <<EOH
          <p>我們教育推廣計畫的使命是為大學生和高中生提供計算基因組學方面的研究培訓機會。透過為這些學生提供計算基因組學的實作培訓，我們希望讓他們了解基因組資訊/數據集的性質，以及透過將計算工具應用於基因組資訊所能解決的無數引人入勝的生物學問題。(The mission of our educational outreach program is to provide research-training opportunities in computational genomics to undergraduates and high school students.)</p>

          <p>高通量 DNA 定序的引入永遠改變了生命科學研究的本質。生物學家不再受限於收集遺傳資訊的能力，而是受限於將這些資訊轉化為發現的能力。從這些數據中組織、儲存、策展和提取生物學見解是當今生物學面臨的核心挑戰。為了應對這項挑戰，我們必須吸引並培訓兼具數學與計算能力、同時具備引導他們解決重要生物學問題之生物學直覺的學生。(The introduction of high capacity DNA sequencing has changed forever the nature of life sciences research.)</p>

    <h4>學生研究機會(Student Research Opportunities)</h4>
    <a name="internships"></a>
          <p><a href="/">SOL Genomics Network</a> 提供大學生研究職缺，該網站是茄科植物家族（包括番茄、馬鈴薯和茄子等重要作物物種）的基因組資訊資料庫。(Undergraduate positions are available at the SOL Genomics Network...)</p>

          <p>我們正在尋找對電腦和生物學有濃厚興趣且積極進取的個人，以參與不同的生物資訊學問題研究，包括為植物科學家編寫新工具的網頁程式，以及為基因組學應用設計和實現關聯式資料庫。(We are seeking highly motivated individuals with strong interests in computers and biology to work on different bioinformatics problems...)</p>

          <p>具備 Perl、SQL 以及 Linux、BSD 或其他類 UNIX 作業系統知識者尤佳，但非必備條件。(Knowledge of Perl, SQL, and Linux, BSD or other UNIX-like operating systems are desirable, but not required.)</p>

          <p>提供計時給薪職位與榮譽生職位。鼓勵勤工助學學生申請。若要申請，請將過往經驗/興趣摘要、相關課程清單以及至少 2 位推薦人的姓名/電子郵件地址寄送至：Joyce Van Eck, <a href="mailto:jv27\@cornell.edu">jv27\@cornell.edu</a>。(To apply, please send a summary of prior experience/interests, list of relevant course work and names/e-mail addresses of at least 2 references by e-mail.)</p>

EOH
		       );

$page->footer();
