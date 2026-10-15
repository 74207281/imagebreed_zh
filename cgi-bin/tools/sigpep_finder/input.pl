#!/usr/bin/perl
# User interface for a signal peptide finder using a genentech-generated HMMER model
# This file modified by Evan 9 / 16 / 05

use strict;
use warnings;
use utf8;
use CXGN::Page;

our $page = CXGN::Page->new("Signal Peptide Finder Input Form", "Evan");
$page->header("訊號肽搜尋器(Signal Peptide Finder)",'訊號肽搜尋器(Signal peptide finder)');

print <<HTML1;

<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;此搜尋訊號序列之方法旨在作為 SignalP（目前為 <a href="http://www.cbs.dtu.dk/services/SignalP/">3.0 版</a>，本方法已針對其進行測試）的補充，總體上具有大致相同的成功率。我們希望開發 SignalP 替代方案的最重要原因在於，SignalP 完全是基於動物序列進行訓練；對於某些僅存在於植物中的蛋白質家族，其表現不如 SGN（主要關注植物家族）所期望的那樣好。(This method of searching for signal sequences is designed to complement SignalP, and in general has approximately the same success rates.)</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;序列使用靜態 <a href="http://hmmer.janelia.org/">HMMER 2.3.2</a> 模型進行 HMMSEARCH，該模型專門由番茄、甜椒、菸草和 <a href="http://www.arabidopsis.org/"><i>Arabidopsis</i></a> 序列建立，這些序列經實驗確定具有極高的分泌機率。(The sequences are HMMSEARCHed with a static HMMER 2.3.2 model created exclusively from tomato, pepper, tobacco and Arabidopsis sequences experimentally determined to have very high probability of being secreted.)</p>
<p><b>請輸入單一純文字序列或一系列 FASTA 序列。(Enter a single plaintext sequence or a series of FASTA sequences.)</b></p>
<p>請使用 <a href="http://embnet.ccg.unam.mx/docs/perl-doc/bioperl.html#amino%20acid%20alphabet">IUPAC 胺基酸字母表(IUPAC amino acid alphabet)</a>。
例外：不接受 B、X 和 Z；接受 *（表示序列結束）。(Exceptions: B, X and Z are not accepted; * denoting the end of a sequence is accepted.)
</p><p>
序列在處理前會進行截斷。我們實際上不太可能考慮前 50 個符號之後的內容。(Sequences are truncated before processing. It is not likely we actually consider more than the first 50 symbols.)
</p><p>
您一次提交的序列越多，輸出中的分數直方圖呈現效果就越好。(The more sequences you submit at once, the nicer the score histogram in the output will look.)
</p>
<form name="sigseq_form" method="post" action="sigpep_find.pl" enctype="multipart/form-data">
<table summary="" width="100%" border="0" cellpadding="5">
        <tr>
                <td width="40%" valign="top" rowspan="4">
                        <textarea name="sequences" rows="8" cols="44"></textarea>
                        <p>及/或選取檔案(And/or select file)：</p>
                        <input type="file" name="filename" size="28" />
								
					</td>
                <td valign="top">
                        <input type="radio" name="display_opt" value="filter" checked="checked" />篩選輸出(filter output)
					</td>
                <td valign="top">
                        僅顯示分數優於下方閾值的輸出(only display output with scores better than the cutoff(s) below)
					</td>
        </tr>
        <tr>
                <td valign="top">
                        <br /><input type="radio" name="display_opt" value="color" />顯示所有輸出，使用顏色標示(show all output, use colors)
					</td>
                <td valign="top">
                        顯示所有輸出分數，依據下方閾值將良好者標為綠色、較差者標為紅色(display all output scores, good ones in green, bad in red, according to the cutoff(s) below)
					</td>
        </tr>
        <tr>
                <td valign="top">
                        <input type="checkbox" name="use_eval_cutoff" checked="checked" />使用 E-value 閾值(use E-value cutoff)：
                        <br />&nbsp;&nbsp;&nbsp;<input type="text" name="eval_cutoff" size="7" maxlength="6" value="2" />
					</td>
                <td valign="top">
                        設定顯示/不顯示輸出或以紅綠色標示的門檻值(set a threshold for displaying/not displaying output or for displaying in red vs. green)
					</td>
        </tr>
        <tr>
                <td valign="top">
                        <input type="checkbox" name="use_bval_cutoff" checked="checked" />使用 bit-value 閾值(use bit-value cutoff)：
                        <br />&nbsp;&nbsp;&nbsp;<input type="text" name="bval_cutoff" size="7" maxlength="6" value="0" />
					</td>
                <td valign="top">
                        另一項顯示門檻值（每個門檻值都是輸出的可能限制條件）(another display threshold)
					</td>
        </tr>
</table>
<input type="reset" value="重設(Reset)" />
&nbsp;&nbsp;<input type="submit" value="送出(Submit)" />
</form>


HTML1

$page->footer();
