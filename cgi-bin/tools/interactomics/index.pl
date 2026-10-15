use strict;
use utf8;
use CXGN::Page;
use CXGN::Page::Toolbar::SGN;
my $page=CXGN::Page->new("互動體學工具 (Interactomics Tools)","Andrew");
$page->header();


print qq{ 
<body id="body">
<table width="800px" cellpadding="10px">
	<table width="100%">
		<tr><td>
		<a href="/CytoScape/cy1.jnlp">啟動 Cytoscape (Start Cytoscape)</a>
		</td></tr>
	</table>
	<table width="100%">
		<tr><td>
		<div id="footer">
		<b>Cytoscape 的資助由美國國家衛生研究院 (<a href="http://www.nih.gov">NIH</a>) 國家通病醫學科學研究所 (<a href="http://www.nigms.nih.gov">NIGMS</a>，獎助編號 GM070743-01) 及美國國家科學基金會 (<a href="http://www.nsf.gov">NSF</a>) 聯邦補助款提供。
		企業贊助由 <a href="http://www.unilever.com">Unilever PLC</a> 依合約提供。
		</b>
		<p>
		<center>
		<a href="http://cytoscape.org">Cytoscape 首頁 (Cytoscape home)</a>
		|
		<a href="http://www.systemsbiology.org">ISB</a>
		|
		<a href="http://www.ucsd.edu">UCSD</a>
		|
		<a href="http://cbio.mskcc.org">MSKCC</a>
		|
		<a href="http://www.pasteur.fr">Pasteur</a>
		|
		<a href="http://www.agilent.com/">Agilent</a>
		| &copy; 2001-2006 Cytoscape
		</center>
		</div>

		</td></tr>
	</table>

	</td></tr>
</table>
</body>};

$page->footer();
