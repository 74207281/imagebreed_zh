use strict;
use warnings;
use utf8;

use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/info_section_html columnar_table_html info_table_html/;

my $page=CXGN::Page->new('tomato_project_overview.html','html2pl converter');
$page->add_style(text => <<EOS);
#seqpeople a.person {}
#seqpeople div.org {padding-left: 1em; white-space: nowrap;}
EOS
$page->header(('國際番茄定序專案總覽(International Tomato Sequencing Project Overview)') x 2);
print info_section_html( title => '摘要(Abstract)',
			 contents => <<EOH);
EOH

print info_section_html( title => '目標(Objectives)',
			 contents => <<EOH);
番茄定序專案的目標為：(The objectives of the tomato sequencing project are to:)

<ol>
  <li>產生 12 條番茄染色體中每條染色體富含基因之真染色質臂的連續序列(produce a contiguous sequence of the gene rich, euchromatic arms of each of the 12 tomato chromosomes)</li>

  <li>以與來自擬南芥、水稻和其他植物物種的類似數據一致且相容的方式處理和註解此序列。(process and annotate this sequence in a manner consistent and compatible with similar data from Arabidopsis, rice and other plant species.)</li>

  <li>建立比較茄科基因組學的國際生物資訊入口網站，以儲存、處理並向公眾提供來自本專案的序列數據和衍生資訊，以及其他茄科植物的相關基因組活動。(create an international bioinformatics portal for comparative Solanaceae genomics which can store, process, and make available to the public the sequence data and derived information from this project and associated genomics activities in other solanaceous plants)</li>
</ol>
EOH

print info_section_html( title => '更多專案文件(More Project Documents)',
			 contents => <<EOH);
<ul>
<li><a href="/about/tomato_sequencing.pl">國際番茄基因組定序專案首頁(International Tomato Genome Sequencing Project Home)</a></li>
<li><a href="/about/tomato_sequencing_scope.pl">番茄定序範圍與完成標準(Tomato Sequencing Scope and Completion Criteria)</a></li>
</ul>
EOH

#given people, agencies, and emails, make html to list them
sub people_list {
  my $last_org;
  my $last_domain;
  join "\n",
    map {
      my ($name, $org, $email) = @$_ == 3 ? @$_ : ($_->[0],$last_org,$_->[1]);
#      $org =~ s/([A-Za-z][a-z]*)/ucfirst($1)/eg;
      $name =~ s/([A-Za-z][a-z]*)/ucfirst($1)/eg;
      $last_org = $org;
      my ($id,$domain) = split /@/,$email;
      $domain ||= $last_domain;
      $last_domain = $domain;
      $email = $id.'@'.$domain;
      qq|<a class="person" href="mailto:$email">$name</a><div class="org">$org</div>|
    } @_;
}

print info_section_html
  ( title => '參與者與資助(Participants and Funding)',
    contents => ''
    .qq|<div align="right">\n|
    .info_table_html( __multicol => 2,
		      '預估總百萬鹼基數(Est. Total MBases)' => 219, '預估總 BAC 數(Est. Total BACs)' => 2276,
		    )
    ."</div>\n"
    .columnar_table_html
    (
     headings => [
		   '染色體(Chr.)',
		   '國家(Country)',
		   '人員(People)',
		   '資助機構(Grant Agency)',
		   '目標截止日期(Target Deadline)',
		   '預估真染色質大小 (Mb)(Est. Euchromatin Size (Mb))',
		   '預估 BAC 數量(Est. # BACs)',
		  ],
     __border => 1,
     __align => 'ccllccc',
     __tableattrs => 'id="seqpeople" cellspacing="0" cellpadding="0"',
     __alt_freq => 2,
     __alt_offset => 1,
     data => [
	      [1,
	       'USA',
	       people_list(
			   ['J. Giovannoni', 'USDA/ARS','jjg33@cornell.edu'],
		           ['B. Roe', 'University of Oklahoma', 'broe@ou.edu' ],
			   ['J. Van Eck','Boyce Thompson Institute','jv27@cornell.edu'],
			   ['L. Mueller','Boyce Thompson Institute','lam87@cornell.edu'],
			   ['S. Stack','Colorado State U.','sstack@lamar.colostate.edu'],
			  ),
	       'National Science Foundation',
	       'Jan. 2009',
	       24,
	       246,
	      ],
	      [2,
	       'Korea',
	       people_list(['D. Choi','KRIBB Seoul','doil@kribb.re.kr'],
			   ['B.D. Kim','Natl. U.','kimbd@snu.ac.kr'],
			  ),

	       'BioGreen21 Project / RDA<br />Frontier 21 Project / CFCG<br />Ministry of Science and Technology (MOST)',
	       'Feb. 2004, July 2004',
	       26,
	       268,
	      ],
	      [3,
	       'China',
	       people_list(['C. Li','Chinese Acad. Sci.','lichu@msu.edu'],
			   ['Y. Xue','ybxue@genetics.ac.cn'],
			   ['Z. Cheng','zkcheng'],
			   ['M. Chen','mschen'],
			   ['H. Ling','hqling'],
			  ),
	       'Chinese Academy of Science<br />Natural Science Foundation',
	       'Mar. 2004',
	       26,
	       274,
	      ],
	      [4,
	       'UK',
	       people_list(['G. Bishop','Imperial College','gdb@aber.ac.uk'],
			   ['G. Seymour','Nottingham University','graham.seymour@hri.ac.uk'],
			   ['G. Bryan', 'SCRI', 'glenn.bryan@scri.ac.uk'],
			  ),
	       'BBSRC/DEFRA, SEERAD',
	       'Jan. 2004',
	       19,
	       193,
	      ],
	      [5,
	       'India',
	       people_list(['R.P. Sharma','U. Hyderabad','rpssl@uohd.ernet.in'],
			   ['J. Khurana,','khurana@genomeindia.org'],
			   ['A. Tyagi','akhilesh'],
			   ['N.K. singh','National Research Centre<br />on Plant Biotech., IARI','nksingh@nrcpb.org'],
			  ),
	       'DBT, Govt. of India',
	       '-',
	       11,
	       111,
	      ],
	      [6,
	       'The Netherlands',
	       people_list(['w. stiekema','Centre for<br />Biosystems Genomics','willem.stiekema@cbsg.nl'],
			   ['p. lindhout','Wageningen U.','Pim.Lindhout@wur.nl'],
			   ['t. jesse','KeyGene','Taco.Jesse@keygene.com'],
			   ['R. Klein Lankhorst','Wageningen U.','rene.kleinlankhorst@wur.nl'],
			  ),
	       'Funded',
	       'in progress',
	       20,
	       213,
	      ],
	      [7,
	       'France',
	       people_list(['m. bouzayen','BMPMF','bouzayen@flora.ensat.fr']),
	       'National Agency for Genome Sequencing',
	       'Mar. 2004',
	       27,
	       277,
	      ],
	      [8,
	       'Japan',
	       people_list(['D. Shibata','Kazusa Inst.','shibata@kazusa.or.jp'],
			   ['S. Tabata','tabata'],
			  ),
	       'Chiba Prefecture',
	       'Sep. 2004',
	       17,
	       175,
	      ],
	      [9,
	       'Spain',
	       people_list(['A. Granell','Inst. de Biologia Molecular<br />y Cellular de Plantas Valencia','agranell@ibmcp.upv.es'],
			   ['M. Botella','U. Malaga','mabotella@uma.es'],
			  ),
	       'Submitted to Genoma Espana',
	       'Pending',
	       16,
	       164,
	      ],
	      [10,
	       'USA',
	       '(see above)',
	      ],
	      [11,
	       'China',
	       people_list(['S. Huang', 'Chinese Academy of Sciences', 'huangsanwen@mac.com']), '', 'Funded',
	      ],
	      [12,
	       'Italy',
	       people_list(['G. Giuliano','ENEA','giovanni.giulianog@enea.it'],
			   ['L. Fruciante','U. Naples','fruscian@unina.it'],
			  ),
	       'Italian Ministry of Agriculture and Italian Ministry of Research',
	       'May 2004',
	       11,
	       113,
	      ],
	     ],
    )
    ,
  );
$page->footer();
