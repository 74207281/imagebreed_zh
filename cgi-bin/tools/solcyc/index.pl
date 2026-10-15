use strict;
use warnings;
use utf8;
use CXGN::Page;
use CXGN::Page::FormattingHelpers qw / blue_section_html page_title_html /;

my $page=CXGN::Page->new("SGN SolCyc","Lukas");

$page->header();
	  
print page_title_html("<a href=\"http://solcyc.solgenomics.net/\">SolCyc</a> 生物化學途徑(Biochemical Pathways)");

print qq {

<img src="/documents/img/ptools.png" border="0" alt="" />
<div class="boxbgcolor1">
<p>
SolCyc 是利用 <a href="http://www.sri.com">SRI International</a> 的 <a href="http://bioinformatics.ai.sri.com/ptools/">Pathway Tools</a> 軟體為茄科物種產生的途徑基因組資料庫 (PGDBs) 集合，該軟體亦用於 <i>Arabidopsis thaliana</i> 的 <a href="http://www.arabidopsis.org/tools/aracyc/">AraCyc</a> 及 <i>E. coli</i> 的 <a href="http://www.ecocyc.org">EcoCyc</a>。(SolCyc is a collection of Pathway Genome Databases (PGDBs) for Solanaceae species generated using Pathway Tools software from SRI International...)
</p>
<p>
目前提供番茄、馬鈴薯及甜椒的資料庫，由註解之 SGN unigene 序列產生。最初的自動構建幾乎未經人工策展。茄子資料庫已不再支援或提供。(Currently, databases for tomato, potato, and pepper are available, generated from the annotated SGN unigene sequences.)
</p>

<ul>
<li>LycoCyc (番茄/tomato): <a href="http://solcyc.solgenomics.net/LYCO/server.html">查詢頁面(Query page)</a> | <a href="http://solcyc.solgenomics.net/LYCO/NEW-IMAGE?type=OVERVIEW&amp;force=t">途徑總覽圖(Pathway overview diagram)</a></li>
<li>PotatoCyc (馬鈴薯/potato): <a href="http://solcyc.solgenomics.net/POTATO/server.html">查詢頁面(Query page)</a> | <a href="http://solcyc.solgenomics.net/POTATO/NEW-IMAGE?type=OVERVIEW&amp;force=t">途徑總覽圖(Pathway overview diagram)</a> </li>
<li>CapCyc (甜椒/pepper): <a href="http://solcyc.solgenomics.net/CAP/server.html">查詢頁面(Query page)</a> | <a href="http://solcyc.solgenomics.net/CAP/NEW-IMAGE?type=OVERVIEW&amp;force=t">途徑總覽圖(Pathway overview diagram)</a></li>
<li>CoffeaCyc (咖啡/coffee): <a href="http://solcyc.solgenomics.net/COFFEA/server.html?">查詢頁面(Query page)</a> | <a href="http://solcyc.solgenomics.net/COFFEA/NEW-IMAGE?type=OVERVIEW&amp;force=t">途徑總覽圖(Pathway overview diagram)</a></li>
<li>PetuniaCyc (矮牽牛/petunia): <a href="http://solcyc.solgenomics.net/PET/server.html?">查詢頁面(Query page)</a> | <a href="http://solcyc.solgenomics.net/PET/NEW-IMAGE?type=OVERVIEW&amp;force=t">途徑總覽圖(Pathway overview diagram)</a></li>
<li>NicotianaCyc (菸草/tobacco): <a href="http://solcyc.solgenomics.net/TOBACCO/server.html?">查詢頁面(Query page)</a> | <a href="http://solcyc.solgenomics.net/TOBACCO/NEW-IMAGE?type=OVERVIEW&amp;force=t">途徑總覽圖(Pathway overview diagram)</a></li>
</ul>

<p>
未來將產生更多資料庫，並透過新增更多茄科特異途徑來改進註解。(More databases will be generated in the future, and the annotation will be improved by adding more Solanaceae specific pathways.)
</p>
<p>
請注意 <a href="http://solcyc.solgenomics.net/expression.html">Omics 檢視器(Omics viewer)</a> 的可用性，該檢視器允許將微陣列、基因晶片、蛋白質體學與代謝體學資訊疊加在途徑總覽圖上。(Note the availability of the Omics viewer, which allows microarray, gene chip, proteomics, and metabolomic information to be overlaid over the pathway overview diagrams.)
</p>
</div>

<p>
<img src="/documents/img/ptools.png" border="0" alt="" />
</p>

<b>Pathway Tools 的程式化介面(Programmatic interfaces for Pathway Tools)</b>：<br />
我們目前為 Pathway Tools 維護 Perl 介面與 Java 介面：
<a href="ftp://ftp.solgenomics.net/programs/javacyc/javacyc.tar.gz">JavaCyc</a> 與 <a href="ftp://ftp.solgenomics.net/programs/perlcyc/perlcyc.tar.gz">PerlCyc</a>。更多資訊可在 <a href="/downloads/">軟體下載(software downloads)</a> 頁面取得。

};

$page->footer();
