use Modern::Perl;
use utf8;
use CXGN::Page;
use CXGN::DB::Connection;
use CXGN::Marker::Tools;
use CXGN::Accession;
use CXGN::Accession::Tools;
use CXGN::Login;
use CXGN::Tools::Text;

my $dbh=CXGN::DB::Connection->new();

my $login=CXGN::Login->new($dbh);
$login->verify_session();

my $page=CXGN::Page->new('cosii_submission.pl','john');

$page->header('提交 COSII 引子實驗 (Submit COSII primer experiment)');
my($action,$marker_name,$accession_id,$primer_type,$temp,$mg,$bands)=$page->get_encoded_arguments('action','marker_name','accession_id','primer_type','temp','mg','bands');
my $marker_id;
my $accession_name;

if($action eq 'verify' or $action eq 'insert') {
    my @marker_ids=CXGN::Marker::Tools::marker_name_to_ids($dbh,$marker_name);

    unless(@marker_ids) {
        $page->message_page("找不到分子標記 '$marker_name' (Marker '$marker_name' not found)。");
    }

    #i don't want to write any error handling here, because all cosii marker names (currently) refer to one marker each
    if(@marker_ids>1) {
        $page->message_page("找到多個名稱為 '$marker_name' 的分子標記。請聯絡我們以解決此問題 (Multiple markers found with name '$marker_name'. Please contact us to resolve this issue)。");
    }

    ($marker_id)=@marker_ids;

    #test accession
    my $accession=CXGN::Accession->new($dbh,$accession_id);
    unless($accession) {
        $page->message_page("資料庫中找不到種原 ID '$accession_id' (Accession ID '$accession_id' not found in database)。");
    }
    $accession_name=$accession->verbose_name();

    #test primer type
    unless($primer_type eq 'iUPA' or $primer_type eq 'eUPA') {
        $page->message_page("未知的引子類型 '$primer_type' (Primer type '$primer_type' is unknown)。");
    }

    #test temp
    unless($temp=~/^\d+$/) {
        $page->message_page("無法辨識溫度 '$temp'，請僅輸入整數 (Temperature '$temp' is unrecognized, please submit a whole number only)。");
    }
    if($temp>500) {
        $page->message_page("溫度 '$temp' 無效 (Temperature '$temp' is invalid)。");
    }

    #test mg
    unless(CXGN::Tools::Text::is_number($mg)) {
        $page->message_page("無法辨識 Mg 濃度，請僅輸入數字或包含一位小數點的數字 (Mg concentration is unrecognized, please submit a number or a number including one decimal point only)。");
    }

    #test bands
    unless($bands eq 'M' or $bands eq 'm' or $bands=~/^\d+$/ or $bands=~/^\d+\+\d+$/) {
        $page->message_page("無法辨識條帶大小，請參考範例並確保輸入中不包含任何空格 (Band sizes are unrecognized, please see examples and be sure not to include any spaces in your input)。");
    }
    if($bands eq 'm') {
        $bands='M';
    }
}





if($action eq 'verify')
{
    print CXGN::Page::FormattingHelpers::page_title_html('核對資料 (Verify data)');
    print"<b>分子標記名稱 (Marker name):</b> $marker_name (SGN-M$marker_id)<br />";
    print"<b>種原 (Accession):</b> $accession_name (SGN accession ID: $accession_id)<br />";
    print"<b>引子類型 (Primer type):</b> $primer_type<br />";
    print"<b>溫度 (Temperature):</b> $temp<br />";
    print"<b>Mg 濃度 (Mg concentration):</b> $mg<br />";
    print"<b>條帶 (Bands):</b> $bands<br /><br />";
    print <<END_HTML;
<form method="post" action="">
<input type="hidden" name="marker_id" value="$marker_id" />
<input type="hidden" name="marker_name" value="$marker_name" />
<input type="hidden" name="accession_id" value="$accession_id" />
<input type="hidden" name="primer_type" value="$primer_type" />
<input type="hidden" name="temp" value="$temp" />
<input type="hidden" name="mg" value="$mg" />
<input type="hidden" name="bands" value="$bands" />
<input type="hidden" name="action" value="insert" />
<input type="submit" value="新增資料 (Add new data)" />
END_HTML
    exit(0);
}





if($action eq 'insert')
{
    print CXGN::Page::FormattingHelpers::page_title_html('已模擬新增此資料 (Pretended to add this data)');
    print"<a href=\"/search/markers/markerinfo.pl?marker_id=$marker_id\">[檢視包含新資料的分子標記 (View marker with new data)]</a><br /><br />";
    print"<b>分子標記名稱 (Marker name):</b> $marker_name (SGN-M$marker_id)<br />";
    print"<b>種原 (Accession):</b> $accession_name (SGN accession ID: $accession_id)<br />";
    print"<b>引子類型 (Primer type):</b> $primer_type<br />";
    print"<b>溫度 (Temperature):</b> $temp<br />";
    print"<b>Mg 濃度 (Mg concentration):</b> $mg<br />";
    print"<b>條帶 (Bands):</b> $bands<br />";
    print"<hr />"
}





my $marker_name_filled_in='C2_At';
if($marker_name)
{
    $marker_name_filled_in=$marker_name;
}
my $temp_filled_in='55';
if($temp)
{
    $temp_filled_in=$temp;
}
my $mg_filled_in='1.5';
if($mg)
{
    $mg_filled_in=$mg;
}
my $bands_filled_in='';
if($bands)
{
    $bands_filled_in=$bands;
}
my @accessions=CXGN::Accession::Tools::all_accessions($dbh);
my $accessions_selector='<select name="accession_id">';
for my $accession_hash(sort {$a->{verbose_name} cmp $b->{verbose_name}} @accessions)
{
    my $each_accession_id=$accession_hash->{accession_id};
    my $each_accession_name=$accession_hash->{verbose_name};
    #warn"$each_accession_id\n";
    my $selected='';
    if($each_accession_id==$accession_id)
    {
        $selected=' selected="selected" ';
    }
    $accessions_selector.="<option value=\"$each_accession_id\" $selected>$each_accession_name</option>";
}
$accessions_selector.='</select>';
my $iupa_selected='checked="checked"';
my $eupa_selected='';
if($primer_type and $primer_type eq 'eUPA')
{
    $iupa_selected='';
    $eupa_selected='checked="checked"';
}
print <<END_HTML;
<center>
<form method="post" action="">
<table cellspacing="10" cellpadding="10" border="0">

<tr>
<td>
分子標記名稱 (Marker name)<br />
<input type="text" name="marker_name" value="$marker_name_filled_in" /><br />
</td>
<td>
引子類型 (Primer type)<br />
<input type="radio" name="primer_type" value="iUPA" $iupa_selected />iUPA<br />
<input type="radio" name="primer_type" value="eUPA" $eupa_selected />eUPA
</td>
</tr>

<tr>
<td colspan="2">
種原 (Accession)<br />
$accessions_selector
<br />若要新增種原至此清單，請<a href="/contact/form">聯絡我們 (contact us)</a>。
</td>
</tr>

<tr>
<td>
溫度 (Temperature &deg;C)<br />
<input type="text" name="temp" value="$temp_filled_in" /><br />
</td>
<td>
Mg 濃度 (Mg concentration)<br />
<input type="text" name="mg" value="$mg_filled_in" /><br /><br />
</td>
</tr>

<tr>
<td>
條帶大小 (Band sizes)<br />
<input type="text" name="bands" value="$bands_filled_in" />
</td>
<td>
條帶大小範例 (Band size examples):<br />
1 個條帶 (1 band): <b>300</b><br />
以 '+' 號分隔的 2 個條帶 (2 bands separated by a '+' sign): <b>300+500</b><br />
超過 2 個請填 'M' ('M' for more than 2): <b>M</b>
</td>
</tr>

<tr>
<td colspan="2">
<input type="hidden" name="action" value="verify" />
<input type="submit" value="核對 (Verify)" />
</td>
</tr>

</table>
</form>    
</center>
END_HTML
$page->footer();
