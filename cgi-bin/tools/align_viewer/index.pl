use CatalystX::GlobalContext qw( $c );
use strict;
use warnings;
use utf8;

use CXGN::Page;
use CXGN::Page::FormattingHelpers qw/  page_title_html
                                       blue_section_html  /;
use HTML::Entities;
#Get input, if this page is loaded from find_caps.pl
my $page = CXGN::Page->new( "比對瀏覽器 (Align Browser)", "Chenwei");
my ($seq_data, $id_data, $format, $title, $type,
    $show_prot_example, $show_cds_example, $show_id_example,
    $temp_file, $maxiters) = $page->get_arguments(
    qw/seq_data id_data format title type
    show_prot_example show_cds_example show_id_example
    temp_file maxiters/
);

my ($intro_content, $input_content);

my $HTML_ROOT = $c->get_conf('basepath');
my $DOC_PATH =  $c->get_conf('tempfiles_subdir').'/align_viewer';
my $PATH = $HTML_ROOT . $DOC_PATH;
if( $temp_file ) {
    $temp_file = $c->path_to( $c->generated_file_uri('align_viewer',$temp_file) );
    if(-f $temp_file){
        $seq_data = $temp_file->slurp;
    }
}


#############################################################
#Create introduction content'
$intro_content = <<HTML;
<p>此工具用於分析序列比對。請<b>僅輸入已比對序列 (aligned sequences only)</b>，支援 fasta 或 clustal 格式。</p>
其功能包括：
<ol>
<li>影像化顯示。</li>
<li>基於比對中序列對之間的重疊和相似性，計算並輸出兩兩相似度，以及推定的剪接變體或等位基因對。</li>
<li>提供使用者隱藏部分比對序列的選項，使其不參與分析。</li>
<li>選擇要分析的序列範圍。</li>
<li>評估比對成員與其他成員的重疊情況。</li>
<li>計算每條比對序列的非間隙中點，並依重疊情況進行序列分組。</li>
</ol>
HTML

$title||="";

#############################################################
#Create input content
$input_content = <<HTML;
<form method="post" action="show_align.pl" name="aligninput" enctype="multipart/form-data">

<input type="submit" name="submit" value="分析比對 (Analyze Alignment)" /><br /><br />
<b>標題 (選填, Title optional): </b>&nbsp;&nbsp;
<input type="textbox" name="title" size="16" value="$title">
<br /><br />
HTML

#Alignment type
if(!$type) { $type = "pep" }
my %type_checked = ( pep => "", nt => "", cds => "" );
$type_checked{$type} = "checked=\"checked\"";
my ($tcn, $tcp, $tcc) = map { $type_checked{$_} } qw/ nt pep cds /;

$input_content .= <<HTML;
<b>類型 (Type)</b>&nbsp;&nbsp;
<input id="aligninput.radio.nt" type="radio" name="type" value="nt" $tcn/>核苷酸 (nucleotide) &nbsp;&nbsp;
<input id="aligninput.radio.pep" type="radio" name="type" value="pep" $tcp/>胜肽 (peptide) &nbsp;&nbsp;
<input id="aligninput.radio.pep" type="radio" name="type" value="cds" $tcc/>CDS (功能最強大, most powerful)
<br /><br />
HTML


#############################
#Input format let it be unaligned by default
if (!$format) { $format="fasta_unaligned"; }

my %format_checked = ( clustalw => "",
		fasta => "",
		fasta_unaligned => "",
		);

$format_checked{$format}="checked=\"checked\"";
$maxiters ||= 2;
my ($fcw, $fcf, $fcu) = map { $format_checked{$_} } qw/clustalw fasta fasta_unaligned/;

$input_content .= <<HTML;
<b>輸入格式 (Input format)</b><br />
您可以使用斜線指定序列物種，例如 "AT1G01010.1/Arabidopsis" <br /> 
請確保識別碼和物種名稱中的所有空格均替換為 '_'。<br />
<input type="radio" name="format" value="clustalw" $fcw/>Clustal 比對 (Clustal Alignment)<a target="blank" href="/about/clustal_file.pl"> [這是什麼？]</a><br />
<input type="radio" name="format" value="fasta" $fcf/>FASTA 比對 (包含間隙, With Gaps)<br /><br />
<input type="radio" name="format" value="fasta_unaligned" $fcu/>未比對 FASTA (將使用 <a href="http://www.drive5.com/muscle/">Muscle 3.6</a> 進行比對，限制 200 條序列)<br />

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;最大疊代次數 (Max Iterations) 
<input type="text" name="maxiters" value=$maxiters>
 使用更多疊代以獲得更高的精確度。上限為 1000。<br /><br />
<!--
<input type="radio" name="run" value="cluster" checked="1">run on cluster (preferred)<br />
<input type="radio" name="run" value="local">run on localhost<br /><br />
-->
HTML

if($show_prot_example){
	$seq_data = $page->path_to("cgi-bin/tools/align_viewer/data/prot_example.txt")->slurp;
}
elsif($show_cds_example){
	$seq_data = $page->path_to("cgi-bin/tools/align_viewer/data/cds_example.txt")->slurp;
}
elsif($show_id_example){
	$id_data = <<HEREDOC;
SGN-U282881 SGN-U228103 At1g09155.1 At1g56240.1 At1g56250.1 NP_178331.2 At2g02350.1 At2g02320.1 At2g02340.1 At2g02360.1 At2g02250.1 At2g02240.1 At2g02300.1 At2g02310.1 SGN-U211584 SGN-U219097 SGN-U219098 SGN-U311800 SGN-U218282 SGN-U218283 At5g24560.1 SGN-U204215 SGN-U221580 SGN-U282885 SGN-U234276 SGN-U220091 SGN-U305684 SGN-U219720
HEREDOC
}

$seq_data ||= '';
###############################
#Text area for input sequences
$input_content .= <<HTML;
<b>輸入 fasta/clustal 序列 (Input fasta/clustal sequences)</b>
&nbsp;&nbsp;
<a href="index.pl" onclick="
	document.getElementById('textarea_seq_data').value = '';
	return false">(x) 清除 (Clear)</a><br />
<textarea id="textarea_seq_data" name="seq_data" rows="12" cols="80">$seq_data</textarea><br /><br />
<b>或使用識別碼，以空格分隔 (Or use identifiers, separated by spaces)</b><br />
 支援 TAIR AGI [AT1G01010.1]、SGN Unigene [SGN-U332332] 或任何 NCBI/Entrez 識別碼<br />
<textarea id="textarea_id_data" name="id_data" rows="2" cols="80">$id_data</textarea><br /><br />
<b>或上傳 fasta/clustal 檔案 (Or upload a fasta/clustal file)</b> <input type="file" name="upload" /><br />
<br /><br />


<input type="submit" name="submit" value="分析比對 (Analyze Alignment)" />
</form>

HTML


# Print Page

$page->header();


my $example_link = <<HTML;
&nbsp;&nbsp;&nbsp;<span style="color:#669">
<a href="index.pl?&format=fasta&title=Alignment%20Example&type=pep&show_prot_example=1">
已比對範例 (Aligned Example)</a>
&nbsp;|&nbsp;
<a href="index.pl?&format=fasta_unaligned&maxiters=300&title=CDS%20Example&type=cds&show_cds_example=1">未比對範例 (Unaligned Example)</a>
&nbsp;|&nbsp;
<a href="index.pl?&maxiters=10&title=ID%20Input%20Example&&type=pep&format=fasta_unaligned&show_id_example=1">識別碼範例 (ID Input Example)</a>
</span>
HTML

print page_title_html("比對分析器 (Alignment Analyzer)");

#print blue_section_html('Introduction','<table width="100%" cellpadding="5" cellspacing="0" border="0" summary=""><tr><td>' . $intro_content . '</td></tr></table>');

print blue_section_html(
	"<span style=\"white-space:nowrap\">查詢輸入 (Query Input) &nbsp;&nbsp;&nbsp;&nbsp;$example_link</span>",
	'<table width="100%" cellpadding="5" cellspacing="0" border="0" summary=""><tr><td>' . $input_content . '</td></tr></table>');


$page->footer();

