#!/usr/bin/perl -w

#######################################################
#
#page to display the intron search form
#
#######################################################

use strict;
use warnings;
use utf8;
use CXGN::Page;

our $page = CXGN::Page->new( "Intron Finder", "Emil Keyder");

$page->header("番茄 EST 序列內含子搜尋器(Intron Finder For Tomato EST sequences)", '茄科 EST 內含子搜尋器(Intron finder for Solanaceae ESTs)');

print <<ENDINTRO;
SGN 內含子搜尋器透過 BLAST 搜尋與輸入 DNA 轉譯蛋白質序列相似的擬南芥 (Arabidopsis thaliana) 蛋白質來運作。接著查詢擬南芥蛋白質的基因模型，並將內含子位置對應回輸入序列。比對下方顯示的數字對應於 DNA 序列位置編號。(The SGN Intron Finder works by doing a blast search for Arabidopsis Thaliana proteins that are similar to the translated protein sequence of the DNA input. The gene models of the Arabidopsis proteins are then looked up, and the intron positions are mapped back to the input sequence. The numbers displayed under the alignments correspond to DNA sequence numbers.)<br/><br/>  

<b>備註(Note)</b>：加利福尼亞大學柑橘基因組學計畫亦獨立開發了<a href="http://int-citrusgenomics.org/usa/ucr/Files.php">類似工具</a>。<br/><br/>

請以 FASTA 格式輸入您的查詢序列。(Please enter your query in FASTA format.)<br/><br/>
ENDINTRO

print <<EOF;

<form method="post" action="display_introns.pl" name="findintrons">

<textarea name="genes" rows="10" cols="100"></textarea> <br/><br/>

<table summary="" width="98%">
<tr>
    <td>
    輸入 BLAST 的 E-value 值(Enter an e-value for blast)：<input type="text" name="blast_e_value" value="1e-50" />
    </td>
   <td align="right">
    <input type="submit" name="submit" value="尋找內含子(Find introns)" />
   </td>
</tr>
</table>

</form>

EOF

$page->footer();
