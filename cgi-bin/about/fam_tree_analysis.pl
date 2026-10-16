use strict;
use utf8;
use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/  page_title_html
                                       blue_section_html  /;

my ($intro_content, $ref_content);

##########################################
#Define the summary
$intro_content = "<tr><td><p>採用最大概似法 (Maximum Likelihood, ML) 重建 SGN 基因家族的基因樹。建樹軟體為 PAUP*4.0 [1]。樹的重建完全基於基因家族多物種比對中所有成員共享的序列重疊區域。</p><p>由於這些基因家族未知的演化動力學，使用程式套件 MODELTEST [2] 從 56 個預定義模型中選擇最合適的 DNA 替代模型。隨後使用所選模型重建 SGN 基因家族的 ML 樹 [3]。</p><p>為提高鑑定最精確樹的機率，透過 PAUP*4.0 內建的分支界限演算法 (branch and bound algorithm) 搜尋並比較所有可能的樹拓撲。具有最高概似值的樹即為 ML 樹，並展示於家族比對頁面中。</p><p>請注意，所有 SGN 家族基因樹均為無根樹 (un-rooted)。<br />(The maximum likelihood (ML) method was used to reconstruct gene trees for SGN gene families. The software for tree construction was PAUP*4.0 [1]. Trees were reconstructed based strictly on the overlapping region of sequence shared by all members in the gene family multiple species alignments. Please note that all the SGN family gene trees are un-rooted.)</p></td></tr>";


#################################################
#Define references
$ref_content = "<tr><th valign='top'>[1] </th><td>SWOFFORD, D. L., 2003 PAUP*. Phylogenetic Analysis Using Parsimony (*and Other Methods). Version 4. Sinauer Associates, Sunderland, Massachusetts.</td></tr>";

$ref_content .= "<tr><th valign='top'>[2] </th><td>POSADA, D., and K. A. CRANDALL, 1998 MODELTEST: testing the model of DNA substitution, pp. 817-818 in Bioinformatics.</td></tr>";

$ref_content .= "<tr><th valign='top'>[3] </th><td>Wu F. et al, Combining Bioinformatics and Phylogenetics to Identify Large Sets of Single Copy, Orthologous Genes (COSII) for Comparative, Evolutionary and Systematic Studies: A Test Case in Euasterid Plant Species. submitted to Genetics. </td></tr>";


################################################
#Generate the page
our $page = CXGN::Page->new( "Gene Family Tree Help Page", "Chenwei Lin");
$page->header('SGN 基因家族樹說明 (Gene Family Tree Help Page)');
print page_title_html("SGN 基因家族樹 (SGN Gene Family Tree)");


print blue_section_html('介紹 (Introduction)','<table width="100%" summary="" cellpadding="3" cellspacing="0" border="0">'.$intro_content.'</table>');

print blue_section_html('參考文獻 (References)','<table width="100%" summary="" cellpadding="3" cellspacing="0" border="0">'.$ref_content.'</table>');





$page->footer();
