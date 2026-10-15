use CXGN::Page;

use strict;
use utf8;
use CXGN::DB::Connection;

library_info_main();

sub library_info_main {

     our $page = CXGN::Page->new( "SGN 基因庫資訊 (SGN Library Info)", "Lukas");

     my ($library) = $page -> get_arguments("library");
     my $db = CXGN::DB::Connection->new();
     
     my $query = "SELECT organism.organism_name, types.comment as type, library_name, library_shortname, development_stage, treatment_conditions, tissue, cultivar, accession,cloning_host, comments, authors, contact_information, cloning_kit, rs1, rs2, library.library_id
                  FROM library, organism, types
                  WHERE library.organism_id=organism.organism_id and library.type=types.type_id and library_shortname=?";
     my $sth = $db -> prepare($query);
     $sth -> execute($library);
     
     my $libraries ="";
     my $lib =$sth-> fetchrow_hashref();

     

     if (!exists($$lib{library_shortname})) {

	 $page -> header();

	 my $temp_value = "<h4>基因庫詳細資訊頁面 (Library Detail Page)</h4> 基因庫 (Library) \n";

    if ($library) {
	$temp_value = $temp_value."\"<b>$library</b>\" \n";
}

$temp_value = $temp_value."查無資料。很抱歉，請重新嘗試。(unknown. Sorry! Please try again.)<br /><br /><br /><br /><br />\n";

	 print $temp_value;

	 $page -> footer();
	 return;
     }

     my $query2 = "SELECT count(*) from clone, seqread, est WHERE clone.clone_id=seqread.clone_id and seqread.read_id=est.read_id and clone.library_id=? and est.status=0 and est.flags=0";
     
     my $sth2 = $db->prepare($query2);
     $sth2->execute($lib->{library_id});
     my ($seq_count) = $sth2->fetchrow_array();
     
     my $query3 = "SELECT count(*) from clone WHERE clone.library_id=?";
     my $sth3 = $db -> prepare($query3);
     $sth3 -> execute($lib->{library_id}); 
     my ($clone_count) = $sth3 -> fetchrow_array();

     my $query4 = "SELECT avg(hqi_length), stddev(hqi_length) FROM clone, seqread, est, qc_report where clone.library_id=? and clone.clone_id=seqread.clone_id and seqread.read_id=est.read_id and est.est_id=qc_report.est_id and est.flags=0 and est.status=0 group by clone.library_id";
     my $sth4 = $db -> prepare($query4);
     $sth4 -> execute($lib->{library_id});
     my ($average_seqlen, $std_dev) = $sth4 -> fetchrow_array();
     $average_seqlen = sprintf "%4.1f", $average_seqlen;
     $std_dev = sprintf "%4.1f", $std_dev;
     
     $page -> header();

     print <<HTML;
     
     <h4>$library 基因庫詳細資訊頁面 (Library Detail Page for $library)</h4>
     <table>
     <tr><td width="180">短簡稱 (Short Name):</td><td>$$lib{library_shortname}</td></tr>
     <tr><td>生物體/物種 (Organism):</td><td>$$lib{organism_name}</td></tr>
     <tr><td>基因庫名稱 (Library Name): </td><td>$$lib{library_name}</td></tr>
     <tr><td>總序列數 (Total Sequences): </td><td>$seq_count 條序列（來自 $clone_count 個選殖株）</td></tr>
     <tr><td>平均序列長度 (Average Sequence Length):</td><td>$average_seqlen（標準差 $std_dev）</td></tr>
     <tr><td>類型 (Type):</td><td>$$lib{type}</td></tr>
     <tr><td>組織 (Tissue):</td><td>$$lib{tissue}</td></tr>
     <tr><td>發育階段 (Development Stage):</td><td>$$lib{development_stage}</td></tr>
     <tr><td valign="top">處理條件 (Treatment Conditions):</td><td>$$lib{treatment_conditions}</td></tr>
     <tr><td>選殖宿主 (Cloning Host):</td><td>$$lib{cloning_host}</td></tr>
     <tr><td>選殖套組 (Cloning Kit): </td><td>$$lib{cloning_kit}</td></tr>
     <tr><td valign="top">備註說明 (Comments):</td><td>$$lib{comments}</td></tr>
     <tr><td valign="top">作者 (Authors):</td><td>$$lib{authors}</td></tr>
     <tr><td valign="top">聯絡資訊 (Contact Information):</td><td>$$lib{contact_information}</td></tr>
     </table>
     <br /><br /><br /><br /><br />

HTML

     $page -> footer();
 }
