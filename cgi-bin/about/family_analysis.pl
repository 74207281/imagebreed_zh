use strict;
use utf8;
use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/  page_title_html
                                       blue_section_html  /;

my ($sum_content, $process_content, $term_content, $ref_content);

##########################################
#Define the summary
$sum_content = "<tr><td><p>SGN 基因家族分析根據序列相似性對蛋白質進行分組。它整合了擬南芥蛋白質組以及從 SGN unigene（目前來自番茄屬合併、馬鈴薯、茄子、辣椒和雜交矮牽牛）和咖啡 unigene 預測的多肽。<br />(SGN gene family analysis groups proteins based on their sequence similarity. It incorporates the Arabidopsis proteome and peptides predicted from SGN unigenes and coffee unigenes.)</p></td></tr>";

##########################################
#Define the process
$process_content = "<tr><th valign=\"top\">1. </th><td>將 SGN 和咖啡 unigene 提交至 ESTScan（一種基於 HMM 的程式，用於從 EST 序列預測編碼區和相應的多肽[1]）。(SGN and coffee unigenes are subjected to ESTScan, an HMM-based program to predict coding regions and the corresponding peptide from EST sequences[1].)</td></tr>";

$process_content .= "<tr><th valign=\"top\">2. </th><td>將預測的 SGN 和咖啡多肽與擬南芥預測蛋白質結合。在合併的蛋白質資料集中進行自身 blastp 比對[2]。(Predicted SGN and coffee peptides are combined with Arabidopsis predicted proteins. A self blastp is performed in the combined protein data set[2].)</td></tr>";

$process_content .= "<tr><th valign=\"top\">3. </th><td>將 TRIBE-MCL 程式應用於 blastp 結果，將蛋白質序列聚類為家族[3]。該程式首先將 blastp 結果轉換為相似性矩陣。基於該矩陣，程式接著使用馬可夫聚類 (MCL) 演算法對蛋白質進行分組。(TRIBE-MCL program is applied to the blastp result for clustering protein sequences into families[3]. This program first translates blastp result into a similarity matrix. Based on the matrix, the program then groups the proteins using Markov cluster (MCL) algorithm.)</td></tr>";


#########################################
#Define the terms
$term_content = "<tr><th valign=\"top\">資料集<br />(Data Set)</th><td>擬南芥預測蛋白質與目前 SGN 及咖啡 unigene 建構版本中預測多肽的組合。若上述任何資料集成員更新（例如建立了新的馬鈴薯 unigene 版本），則會產生新資料集並在該資料集中重新執行家族分析。(A combination of Arabidopsis predicted proteins and predicted peptides from current SGN and coffee unigene builds.)</td></tr>";

$term_content .= "<tr><th valign=\"top\">膨脹參數 i 值<br />(i Value)</th><td>TRIBE-MCL 對蛋白質的聚類是透過兩個稱為擴展 (expansion) 和膨脹 (inflation) 的運算元交替進行的。膨脹將基因分組為群集，而擴展則分散群集。i 值控制膨脹的嚴格度。i 值越高，膨脹運算元將基因分組在一起的標準越嚴格。(Clustering of proteins by TRIBE-MCL is carried out by alteration of two operators called expansion and inflation. The higher the i value, the more stringent for inflation operator to group genes together.)</td></tr>";

$term_content .= "<tr><th valign=\"top\">家族建構版本<br />(Family Build)</th><td>家族建構版本由資料集和嚴格度（i 值）唯一確定。對於每個 SGN 資料集，我們使用 3 個 i 值（1.2、2 和 5）進行 TRIBE-MCL 分析，並獲得 3 個家族建構版本。(A family build is uniquely defined by the Data Set and stringency (i Value). For each SGN Data Set, we do TRIBE-MCL analysis with 3 i Values: 1.2, 2 and 5.)</td></tr>"; 

$term_content .= "<tr><th valign=\"top\">物種基因家族<br />(Gene Family of a Species)</th><td>至少包含 1 個來自該物種成員基因的基因家族。(A gene family with at least 1 member gene from the species.)</td></tr>";

$term_content .= "<tr><th valign=\"top\">物種特有基因家族<br />(Unique Gene Family of a Species)</th><td>其成員基因完全排他性地僅來自該物種的基因家族。(A gene family whose member genes are from a species exclusively.)</td></tr>";


#################################################
#Define references
$ref_content = "<tr><th valign=\"top\">[1] </th><td>Iseli C. et al (1999), ESTScan: a Program for Detecting, Evaluating and Reconstructing Potential Coding Regions in EST Sequences, American Association of Artificial Intelligence.</td></tr>";

$ref_content .= "<tr><th valign=\"top\">[2] </th><td>Altschul S.F. et al (1997), Gapped BLAST and PSI-BLAST: a New Generation of Protein Database Search Programs. Nucleic Acids Research 25, 3389-3402.</td></tr>";

$ref_content .= "<tr><th valign=\"top\">[3] </th><td>Enright A.J. et al (2002), An Efficient Algorithm for Large-Scale Detection of Protein Families. Nucleic Acids Research 30, 1575-1584.</td></tr>";




################################################
#Generate the page
our $page = CXGN::Page->new( "Gene Family Help Page", "Chenwei Lin");
$page->header('SGN 基因家族分析說明 (Gene Family Help Page)');
print page_title_html("SGN 基因家族分析 (SGN Gene Family Analysis)");


print blue_section_html('摘要 (Summary)','<table width="100%" summary="" cellpadding="3" cellspacing="0" border="0">'.$sum_content.'</table>');
print blue_section_html('流程步驟 (Procedure)','<table width="100%" summary="" cellpadding="3" cellspacing="0" border="0">'.$process_content.'</table>');
print blue_section_html('名詞定義 (Terms)','<table width="100%" summary="" cellpadding="3" cellspacing="0" border="0">'.$term_content.'</table>');
print blue_section_html('參考文獻 (References)','<table width="100%" summary="" cellpadding="3" cellspacing="0" border="0">'.$ref_content.'</table>');


$page->footer();
