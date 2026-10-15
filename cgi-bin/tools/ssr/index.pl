#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;
use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/  page_title_html
                                       blue_section_html  /;

our $page = CXGN::Page->new("SSR Search", "rfa5");
my ($seq_data, $format, $title, $type) = $page->get_arguments("seq_data", "format", "title", "type");
my ($intro_content, $input_content);


#############################################################
#Create introduction content'
$intro_content = "<p>在批次核苷酸序列中搜尋微衛星序列 (SSR)。(Search for microsatellites (SSRs) in batch nucleotide sequences.)</p>"; 

#############################################################
#Create input content
$input_content = '<form method="post" action="show_ssr.pl" name="ssrinput" enctype="multipart/form-data">';

#############################
#Output type
$input_content .= '<b>輸出類型(Output Type)</b><br /><input type="radio" name="type" value="html" checked="checked" />HTML<br />';
$input_content .= '<input type="radio" name="type" value="tab" />Tab 分隔格式(Tab delimited)<br /><br />';

#############################
#Options
$input_content .= '<b>選項(Options)</b><br />';
$input_content .= '<table width="100%" cellpadding="5" cellspacing="0" border="0" summary=""><tr>';
$input_content .= '<td>輸入最小單元長度(Enter minimum unit length)：<input type="text" name="ssr_min" value="2" size="5" /></td>';
$input_content .= '<td>輸入最大單元長度(Enter maximum unit length)：<input type="text" name="ssr_max" value="10" size="5" /></td>';
$input_content .= '<td>輸入最少重複次數(Enter minimum repeat time)：<input type="text" name="ssr_repeat" value="2" size="5" /></td>';
$input_content .= '</tr></table>';

###############################
#Text area for input sequences
$input_content .= '<b>輸入 FASTA 格式的輸入序列(Enter FASTA formatted input sequences)</b><br />';
$input_content .= "<textarea name=\"seq_data\" rows=\"20\" cols=\"100\">$seq_data</textarea><br /><br />";
$input_content .= '<b>上傳檔案(Upload file)</b> <input type="file" name="upload" /><br /><br /><br />';


#########################################
#Submitbutton
$input_content .= '<input type="submit" name="submit" value="尋找重複序列(Find repeated sequences)" />';
$input_content .= '</form>';

###########################################
#Page Output  

$page->header();
print page_title_html("微衛星標記搜尋(SSR Search)");
print blue_section_html('簡介(Introduction)','<table width="100%" cellpadding="5" cellspacing="0" border="0" summary=""><tr><td>' . $intro_content . '</td></tr></table>');
print blue_section_html('查詢輸入(Query Input)','<table width="100%" cellpadding="5" cellspacing="0" border="0" summary=""><tr><td>' . $input_content . '</td></tr></table>');
$page -> footer();
