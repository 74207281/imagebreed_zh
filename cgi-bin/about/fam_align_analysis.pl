use strict;
use utf8;
use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/  page_title_html
                                       blue_section_html  /;

my ($intro_content, $ref_content);

##########################################
#Define the summary
$intro_content = "<tr><td><p>SGN 基因家族多序列比對使用了擬南芥蛋白質序列以及經 ESTScan 預測之 SGN unigene 多肽序列[1]。採用的多序列比對軟體為 t_coffee [2]。</p><p>比對後，將擬南芥蛋白質的核苷酸編碼序列和 SGN unigene 的預測編碼序列對齊於多肽比對上，保留間隙並產生「多肽引導之核苷酸比對 (peptide guided nucleotide alignment)」。該流程保持了核苷酸與蛋白質之間的聯繫，同時消除了直接使用核苷酸序列比對的複雜性。<br />(SGN gene family multiple sequence alignment used protein sequence of Arabidopsis and ESTScan-predicted peptide sequences of SGN unigenes[1]. The multiple sequence alignment software was t_coffee [2]. Following alignment, nucleotide coding sequences were attached to the peptide alignment, resulting in peptide-guided nucleotide alignment.)</p></td></tr>";


#################################################
#Define references
$ref_content = "<tr><th valign='top'>[1] </th><td>Iseli C. et al (1999), ESTScan: a Program for Detecting, Evaluating and Reconstructing Potential Coding Regions in EST Sequences, American Association of Artificial Intelligence.</td></tr>";

$ref_content .= "<tr><th valign='top'>[2] </th><td>Notredame C. et al, T_Coffee: A Novel Method for Fast and Accurate Multiple Sequence Alignment, J. Mol. Biol., 302:205-217.</td></tr>";


################################################
#Generate the page
our $page = CXGN::Page->new( "Alignment Help Page", "Chenwei Lin");
$page->header('SGN 比對說明 (Alignment Help Page)');
print page_title_html("SGN 基因家族比對 (SGN Gene Family Alignment)");


print blue_section_html('摘要 (Summary)','<table width="100%" summary="" cellpadding="3" cellspacing="0" border="0">'.$intro_content.'</table>');
print blue_section_html('參考文獻 (References)','<table width="100%" summary="" cellpadding="3" cellspacing="0" border="0">'.$ref_content.'</table>');


$page->footer();
