use strict;
use warnings;
use utf8;
use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/  page_title_html
                                       blue_section_html  /;

#Get input, if this page is loaded from find_caps.pl
our $page = CXGN::Page->new( "CAPS Designer", "Chenwei");
my ($format, $cheap_only, $exclude_seq, $cutno, $seq_data, $seq_select) = $page->get_arguments("format", "cheap", "start", "cutno", "seq_data");#, "seq_select");

my ($intro_content, $input_content);

$intro_content = "<tr><td><p>此工具可為最多 12 條序列設計 CAPS 檢測。接受兩種類型的核苷酸輸入：FASTA 序列與 Clustal 比對。它會產生可將序列切割成不同長度產物的多型性限制酶清單。(This tool designs CAPS assays for up to 12 sequences. Two types of nucleotide inputs are accepted: fasta sequences and clustal alignment. It generates a list of polymorphic enzymes that cut the sequences into different length products.)</p>";
$intro_content .= "<b>建議事項(Suggestions)：</b><ol><li>序列兩端的低品質核苷酸和 \"n\" 會產生歧異性。請從輸入序列中將其移除。(Low quality nucleotides and \"n\"s at both ends of a sequence generate ambiguity. Please remove them from the input sequences.)</li><li>太小尺寸的多型性消化片段難以在 1-4% 瓊脂糖凝膠上觀察，因此不適合 CAPS 實驗。請在兩端排除一些核苷酸（例如 20 個）以避免此問題。(Polymorphic digested fragments of too small sizes are hard to visualize on 1-4% agarose gel, thus not suitable for CAPS experiment. Please exclude some nucleotides (for example 20) at both ends to avoid the problem.)</li></ol></td></tr>";


$input_content = '<form method="post" action="find_caps.pl" name="capsinput">';

#Select input format
$input_content .= '<b>輸入格式(Input format)</b><br />';
if ( $format && $format eq "clustalw" ){
  $input_content .= '<input type="radio" name="format" value="clustalw" checked="checked" />Clustal 比對(clustal alignment) <a target="blank" href="/about/clustal_file.pl">[這是什麼？(What is this?)]</a><br />';
  $input_content .= '<input type="radio" name="format" value="fasta" />未比對的 FASTA 序列(unaligned fasta sequences)<br /><br />';
}
else {
  $input_content .= '<input type="radio" name="format" value="clustalw" />Clustal 比對(clustal alignment) <a target="blank" href="/about/clustal_file.pl">[這是什麼？(What is this?)]</a><br />';
  $input_content .= '<input type="radio" name="format" value="fasta" checked="checked" />未比對的 FASTA 序列(unaligned fasta sequences)<br /><br />';
}

{ no warnings 'uninitialized';
#Text area for input sequences
$input_content .= '<b>輸入序列(Input sequences)</b><br />';
$input_content .= "<textarea name=\"seq_data\" rows=\"20\" cols=\"100\">$seq_data</textarea><br /><br /><br /><br />";
}

#Options low price enzyme
$input_content .= '<b>選項(Options)</b><br /><br />';
if ( $cheap_only ){
  $input_content .= '<input type="checkbox" name="cheap" value = "1" checked="checked" /> 尋找價格低於 $65/1000u 的限制酶(Find enzymes priced less than $65/1000u)<br />';
}
else {
  $input_content .= '<input type="checkbox" name="cheap" value = "1" /> 尋找價格低於 $65/1000u 的限制酶(Find enzymes priced less than $65/1000u)<br />';
}

#Option exclude end sequence
if (!$exclude_seq){
  $exclude_seq = 20;
}
$input_content .= "在兩端排除(Exclude) <input type=\"text\" size=\"3\" name=\"start\" value=\"$exclude_seq\" /> 個核苷酸(nucleotides at both ends)<br />";

#Option cutting times
if (!$cutno){
  $cutno = 4;
}
$input_content .= "不顯示對各親本切割超過(Don\'t show enzymes that cut each parent more than) <input type=\"text\" name=\"cutno\" size=\"3\" value=\"$cutno\" /> 次的限制酶(times)<br /><br /><br />";

$input_content .= '<input type="submit" name="submit" value="尋找 CAPS(Find Caps)" />';

$input_content .= '</form>';

#Submit and reset button
$input_content .='<form method="post" action="caps_input.pl" name="capsinput2">';
$input_content .= '<input type="submit" name="submit" value="重設(Reset)" /></form>';
$page->header();
print page_title_html("CAPS 標記設計器(CAPS Designer)");
print blue_section_html('簡介(Introduction)','<table width="100%" cellpadding="5" cellspacing="0" border="0" summary="">' . $intro_content . '</table>');
print blue_section_html('查詢輸入(Query Input)', $input_content);


$page -> footer();
