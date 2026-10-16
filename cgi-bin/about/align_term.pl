use strict;
use utf8;
use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/  page_title_html
                                       blue_section_html  /;

my ($sum_content, $term_content, $ref_content);

##########################################
#Define the summary
$sum_content = "<tr><td><p>SGN 比對檢視器 (Alignment Viewer) 顯示、分析並為使用者提供提示和最佳化比對的機會（獲得可用於基因樹分析的最大重疊比對序列）。<br />(SGN Alignment Viewer displays, analyzes and provides the user with hint and opportunity to optimize the alignment (get maximal overlapping alignment sequences that can be subjected to gene tree analysis).)</p></td></tr>";


#########################################
#Define the terms
$term_content = "<tr><th valign='top'>覆蓋範圍<br />(Cover Range)</th><td>從第一個到最後一個非間隙序列的位置。(The position of the first to the last non-gap sequence.)</td></tr>";

$term_content .= "<tr><th valign='top'>鹼基/殘基數<br />(Bases)</th><td>序列中「真實序列字元」（非間隙）的數量。(Number of \"real sequence characters\" (non gap) in the sequence.)</td></tr>";

$term_content .= "<tr><th valign='top'>間隙<br />(Gaps)</th><td>比對中的間隙。(Gaps in alignment)</td></tr>"; 

$term_content .= "<tr><th valign='top'>中位位置<br />(Medium)</th><td>比對序列中所有非間隙字元的中間位置。(The middle position of all non-gap characters of the alignment sequence)</td></tr>";

$term_content .= "<tr><th valign='top'>推測剪接變異體對<br />(Putative Splice Variant Pairs)</th><td>來自同一物種的序列對，滿足：<b>1.</b> 若為核苷酸則至少共享 60 個鹼基，若為多肽則至少共享 20 個胺基酸。<b>2.</b> 在重疊區域中至少具有 95% 的序列相似性。<b>3.</b> 在其共同區域中具有至少 4 個胺基酸或 12 個核苷酸的插入/缺失。<br />(Sequence pairs that are from the same species, that share overlapping regions with insertions/deletions of at least 4 aa or 12 nt.)</td></tr>"; 

$term_content .= "<tr><th valign='top'>推測等位基因<br />(Putative Alleles)</th><td>來自同一物種的序列對，滿足：<b>1.</b> 若為核苷酸則至少共享 60 個鹼基，若為多肽則至少共享 20 個胺基酸。<b>2.</b> 在重疊區域中至少具有 95% 的序列相似性。<b>3.</b> 在其共同區域中具有<b>不超過</b> 4 個胺基酸或 12 個核苷酸的插入/缺失。<br />(Sequence pairs that are from the same species with insertions/deletions not more than 4 aa or 12 nt.)</td></tr>"; 

$term_content .= "<tr><th valign='top'>重疊評分<br />(Overlap Score)</th><td>表示該序列與比對中其他成員重疊程度的指標。若某序列的字元（非間隙）與另一比對序列的字元重疊，則獲得分數。有時在比對中，只有少數序列與其他序列重疊極少，這會顯著降低整個比對的總重疊序列。通常（但非必然）這些序列較短且無助於理解整體比對。我們建議使用者在進一步分析之前排除這些序列。<br />(An indication of how the sequence overlap with other members in the alignment.)</td></tr>";



################################################
#Generate the page
our $page = CXGN::Page->new( "Gene Family Help Page", "Chenwei Lin");
$page->header('SGN 基因家族說明 (Gene Family Help Page)');
print page_title_html("SGN 比對名詞術語 (SGN Alignment Terms)");


print blue_section_html('摘要 (Summary)','<table width="100%" summary="" cellpadding="3" cellspacing="0" border="0">'.$sum_content.'</table>');
print blue_section_html('名詞定義 (Terms)','<table width="100%" summary="" cellpadding="3" cellspacing="0" border="0">'.$term_content.'</table>');


$page->footer();
