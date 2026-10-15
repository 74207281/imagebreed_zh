#!/usr/bin/perl -w

#Main Page for Phenotypic Database

use strict;
use warnings;
use utf8;
use CXGN::Page;
use CXGN::DB::PhenoPopulation;
use CGI;

#get parameters from form on previous page
use CatalystX::GlobalContext qw( $c );
my %params = %{$c->req->params};
my $pop_id = $params{pop_id};

my $page = CXGN::Page->new('phenotype', 'Adri');

print "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 transitional//EN\" \"http://www.w3.org/tr/xhtml1/DTD/xhtml1-transitional.dtd\">";

$page->header("搜尋表型資料庫(Search the Phenotype Database)");

#-------------------------------------------------
my @populations = CXGN::DB::PhenoPopulation::get_all_populations;
my $current_pop_id;
my $current_pop_name;

#population selected
if ($pop_id) {
  $current_pop_id = $pop_id;
  $current_pop_name = CXGN::DB::PhenoPopulation::get_pop_name_from_pop_id($pop_id);
}

#no population selected, first one in DB is used as default
else {
  $current_pop_id = $populations[0][0];
  $current_pop_name = $populations[0][1];
}

my @genotypes = CXGN::DB::PhenoPopulation::get_all_gen_from_pop_id($current_pop_id);
my @gen_ids;
for my $i (0..$#genotypes) {
  push @gen_ids, $genotypes[$i][0];
}
my @prop_info_by_organ = CXGN::DB::PhenoPopulation::get_all_prop_info_by_organ_from_pop_id($current_pop_id);

print <<EOF

<table summary="" width="100%" cellpadding="0" cellspacing="10" border="0">

<tr><td valign="top">
<table summary="" width="100%" cellpadding="0" cellspacing="0" border="0">

<tr><td>
<center>
<h3><u>歡迎使用表型資料庫(Welcome to the Phenotype Database)</u></h3>
<p>在此頁面中，您可以搜尋表型資料庫以獲取來自所有族群之所有植株的數據與影像。(From this page, you can search the phenotype database for data and images of all plants from all populations.)</p>
<p>有兩種方式可以尋找特定數據與影像：依基因型搜尋與依表型搜尋。(There are two ways to find specific data and images: searching by genotype and phenotype.)</p>
</center>
</td></tr>

<tr><td><img src="/documents/img/dot_clear.gif" width="1" alt="" height="10" /></td></tr>
<tr><td colspan="1" bgcolor="#cccccc"><img src="/documents/img/dot_clear.gif" alt="" width="1" height="1" /></td></tr>
<tr><td><img src="/documents/img/dot_clear.gif" width="1" height="10" alt="" /></td></tr>

<tr><td>
<center><h3><u>搜尋表型資料庫(Search the Phenotype Database)</u></h3></center>

<center>
<table summary="" width="100%" cellpadding="0" cellspacing="0" border="0">

<tr><td>
<!--populations-->
<form action="#" method="get">
<table summary="">
<tr><td valign="top">

EOF
;

print "<b><u>已選取的族群(selected POPULATION)：</u> $current_pop_name</b>";

print <<EOF
</td></tr>
<tr><td><p>以下是目前資料庫中的族群清單。選取族群並點擊按鈕，以搜尋另一個族群中的影像和數據。(Below is the list of population(s) currently in the database. Select a population and click the button to search images and data in another population.)</p></td></tr>
<tr><td valign="top" align="left">
所有族群(All Populations)：
<select name="pop_id">
EOF
;

for (0..$#populations) {
  print "<option value = \"$populations[$_][0]\">$populations[$_][1]</option>";
}

print <<EOF
</select>
</td>
<td valign="top" align="right">
<input type="submit" value="變更族群(Change Population)" />
</td></tr>
</table>
</form>
</td></tr>

<!--genotypes-->

<tr><td>
<form action="/phenotype/display_plants_from_genotype.pl" method="get">
<table summary="">
<tr><td>
<b><u>依基因型搜尋(Search By GENOTYPES)</u></b>
</td></tr>
<tr><td><p>以下是上方所選族群中的所有<b>基因型(genotypes)</b>清單 - 選取基因型將引導您至具有所選基因型的植株頁面。該新頁面將包含這些植株的所有影像和數據連結：(Below is a list of all genotypes in the selected population above - selecting a genotype will take you to a page of plants with the selected genotype. This new page will have links to all images and data of these plants:)</p></td></tr>
<tr><td valign="top" align="left">

EOF
;

print "<b>$current_pop_name</b> 中的基因型(Genotypes)：";
print "<select name=\"gen_id\">";
for my $i (0..$#genotypes) {
  print "<option value = \"$genotypes[$i][0]\"> $genotypes[$i][1]</option>";
}
print "</select>";
print "<input type=\"hidden\" name=\"pop_id\" value=\"$current_pop_id\" />";
print "<input type=\"hidden\" name=\"pop_name\" value=\"$current_pop_name\" />";

print <<EOF
</td>
<td valign="top" align="right">
<input type="submit" value="依基因型取得植株(get Plants by Genotype)" />
</td></tr>
</table>
</form>
</td></tr>

<!--properties-->
<tr><td>
<form action="/phenotype/display_plants_from_property.pl" method="get">
<table summary=""><tr><td>
<b><u>依性狀/屬性搜尋(Search By PROPERTIES)</u></b> (<a href="display_prop_list.pl">性狀描述(Property Descriptions)</a>)
</td></tr>
<tr><td>
EOF
;

print "<p>以下是上方所選族群中測量的所有<b>性狀/屬性(properties)</b>清單 - 選取性狀將引導您至測量了所選性狀的植株頁面。該新頁面將包含每株植株的樣本數據與影像連結：(Below is a list of all properties measured in the selected population above - selecting a property will take you to a page of plants with the selected property measured. This new page will have links to each plant's sample data and images:)</p>";

print "</td></tr>";
print "<tr><td width=\"100%\" valign=\"top\" align=\"left\">";

print "<b>$current_pop_name</b> 中的性狀(Properties)：";
print "<select name=\"prop_id\">";

for (0..$#prop_info_by_organ) {
  my $i = $_;
  $prop_info_by_organ[$i] or next;
  my $organ_name = $prop_info_by_organ[$i][0][2];
  print "<optgroup label=\"$organ_name\">";
  for (0..$#{$prop_info_by_organ[$i]}) {
    my $j = $_;
    my $prop_id = $prop_info_by_organ[$i][$j][0];
    my $prop_name = $prop_info_by_organ[$i][$j][1];
    print "<option value = \"$prop_id\">$prop_name</option>\n";
  }
  print "</optgroup>";
}

print "</select>";
print "<input type=\"hidden\" name=\"pop_id\" value=\"$current_pop_id\" />";
print "<input type=\"hidden\" name=\"pop_name\" value=\"$current_pop_name\" />";

print <<EOF

</td>
<td width="100%" valign="top" align="right">
<input type="submit" value="依性狀取得植株(get Plants by Property)" />
</td></tr></table>
</form>
</td></tr>

</table>
</center>
</td>
</tr>

</table>
</td></tr>

<tr><td><img src="/documents/img/dot_clear.gif" width="1" height="10" alt="" /></td></tr>
<tr><td bgcolor="#cccccc"><img src="/documents/img/dot_clear.gif" width="1" height="1" alt="" /></td></tr>
<tr><td><img src="/documents/img/dot_clear.gif" width="1" height="10" alt="" /></td></tr>

<!--terminology-->
<tr><td>
<center><h3><u>術語詞彙(Terminology)</u></h3></center>

<table summary="" width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td>

<dl>
<dt><b>族群(Population)</b></dt>
<dd>構成特定群體或出現在特定地點的所有生物。(all the organisms that constitute a specific group or occur in a specified location.)</dd>
<dt><br /><b>基因型(Genotype)</b></dt>
<dd>共享特定遺傳組成的生物群體。(a group of organisms sharing a specific genetic constitution.)</dd>
<dt><br /><b>性狀/表型(Property/Phenotype)</b></dt>
<dd>由遺傳組成和環境影響共同決定的生物體可觀察到的物理或生化特徵。(the observable physical or biochemical characteristics of an organism, as determined by both genetic makeup and environmental influences.)</dd>
</dl>

</td></tr>
</table>

</td></tr>

</table>
EOF
;

#--------------------------
$page->footer();
