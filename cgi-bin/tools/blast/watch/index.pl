#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;

use CXGN::Page;
use CXGN::DB::Connection;
use CXGN::Login;

our @databases;

our $page = CXGN::Page->new("SGN BLAST watch","Adri");
my $dbh = CXGN::DB::Connection->new();

my $person_id=CXGN::Login->new($dbh)->verify_session();

&local_init();

$page->header('SGN BLAST 監控 (SGN BLAST Watch)','SGN BLAST 監控 (SGN BLAST Watch)');

print <<EOF;

<form method="post" action="submit.pl">

<table summary="" cellpadding="0" cellspacing="0" border="0" align="center">

<tr><td align="center">每週自動執行 BLAST 查詢。當比對結果有所變更時，系統將透過電子郵件通知您。<br />(Submit a query to be BLASTed weekly. You will be contacted by email when the results change.)</td></tr>

<tr><td><br /></td></tr>

<tr><td><table summary="" cellpadding="0" cellspacing="0" border="0">

<tr><td width="25%"><b>程式 (Program):</b> </td><td>
<select name="program">
<option value="blastn">BLASTN (核苷酸對核苷酸, nucleotide to nucleotide)</option>
<option value="blastx">BLASTX (核苷酸對蛋白質；查詢序列轉譯為蛋白質, nucleotide to protein; query translated to protein)</option>
<option value="blastp">BLASTP (蛋白質對蛋白質, protein to protein)</option>
<option value="tblastx">TBLASTX (蛋白質對蛋白質；資料庫與查詢序列皆轉譯, protein to protein; both database and query are translated)</option>
<option value="tblastn">TBLASTN (蛋白質對核苷酸；資料庫轉譯為蛋白質, protein to nucleotide; database translated to protein)</option>
</select>
</td></tr>

<tr><td colspan="2"><br /></td></tr>

<tr><td><b>資料庫 (Database):</b> </td><td>

<select name="database">
@databases
</select>

</td></tr>
    
<tr><td colspan="2"><br /></td></tr>
    
<tr><td colspan="2" align="center"><b>查詢序列 (Query sequence)</b></td></tr>
   
<tr><td colspan="2" align="center" class="fix">
<textarea name="sequence" rows="8" cols="80"></textarea>
</td></tr>
    
<tr><td colspan="2"><br /></td></tr>
    
<tr><td><b>替代矩陣 (Substitution Matrix):</b> </td><td>
<select name="matrix">
<option value="BLOSUM62">BLOSUM62 (預設, default)</option>
<option value="BLOSUM80">BLOSUM80 (近期分歧, recent divergence)</option>
<option value="BLOSUM45">BLOSUM45 (遠期分歧, ancient divergence)</option>
<option value="PAM30">PAM30</option>
<option value="PAM70">PAM70</option>
</select>
</td></tr>
    
<tr><td colspan="2"></td></tr>

<tr><td><b>預期值門檻 (Expect / e-value Threshold):</b> </td><td>
<input type="text" size="6" value="1.0" name="evalue" />
</td></tr>

<tr><td>
<input type="hidden" value="$person_id" name="sp_person_id" />
</td></tr>

</table>

</td></tr>

<tr><td><br /></td></tr>

<tr><td align="center">
<input type="reset" name="clear" value="清除 (Clear)" />
<input type="submit" name="submit" value="送出 (Submit)" />
</td></tr>

</table>

</form>

<br /><br />

EOF

$page->footer();


sub local_init {

  # This is hard-coded here, but ought to be stored in the database (it was in
  # old SGN), in a way that is automatically updated when the files on disk are
  # updated -- so this script is always in sync. Can't do that now.

  @databases = 
    ( '<optgroup label="標記 (Markers)">',
      '<option value="markers/marker_sequences.fasta">所有 SGN 標記 (All SGN markers)</option>',
      '</optgroup>',
      '<optgroup label="番茄基因體 (Tomato Genome)">',
      '<option value="bacs/tomato_bac_ends">番茄 BAC 末端 (Tomato BAC ends)</option>',
      '<option value="bacs/tomato_bacs">番茄完整 BAC 序列 (Tomato full BAC sequences)</option>',
      '<option value="repeats/mips_repeat_collection">MIPS 番茄重複序列集 (MIPS tomato repeat collection)</option>',
      '<option value="repeats/TIGR_SolAth_repeat">TIGR 番茄/阿拉伯芥重複序列 (TIGR tomato/arabidopsis repeats)</option>',
      '</optgroup>',
      '<optgroup label="SGN ESTs">',
      '<option value="estdb/all_ests">所有 SGN EST (All SGN ESTs)</option>',
      '<option value="estdb/lycopersicon-all">番茄 EST (Tomato ESTs)</option>',
      '<option value="estdb/Solanum_tuberosum">馬鈴薯 EST (Potato ESTs)</option>',
      '<option value="estdb/Capsicum">辣椒 EST (Pepper ESTs)</option>',
      '<option value="estdb/Solanum_melongena">茄子 EST (Eggplant ESTs)</option>',
      '<option value="estdb/Petunia_hybrida">矮牽牛 EST (Petunia ESTs)</option>',
      '</optgroup>',
      '<optgroup label="SGN 單一基因集 (SGN unigenes)">',
      '<option value="unigene/all_current" selected="selected">所有 SGN 單一基因 (All SGN unigenes)</option>',
      '<option value="unigene/Lycopersicon_combined">番茄單一基因 (Tomato unigene)</option>',
      '<option value="unigene/Solanum_tuberosum">馬鈴薯單一基因 (Potato unigene)</option>',
      '<option value="unigene/Capsicum_combined">辣椒單一基因 (Pepper unigene)</option>',
      '<option value="unigene/Solanum_melongena">茄子單一基因 (Eggplant unigene)</option>',
      '<option value="unigene/Petunia_hybrida">矮牽牛單一基因 (Petunia unigene)</option>',
      '<option value="unigene/Coffea_canephora">咖啡單一基因 (Coffee unigene)</option>',
      '</optgroup>',
      '<optgroup label="阿拉伯芥 (Arabidopsis - TAIR)">',
      '<option value="ath1/ATH1_pep">阿拉伯芥蛋白質 (Arabidopsis proteins)</option>',
      '<option value="ath1/ATH1_seq">阿拉伯芥基因模型 (Arabidopsis gene models)</option>',
      '<option value="ath1/ATH1_cds">阿拉伯芥編碼序列 (Arabidopsis coding sequence)</option>',
      '<option value="ath1/ATH1_bacs_con">阿拉伯芥已完成 BAC 序列 (Arabidopsis finished BAC sequences)</option>',
      '</optgroup>',
      '<optgroup label="其他 (Other)">',
      '<option value="genbank/nr">Genbank 非冗餘蛋白質資料庫 (Genbank NR)</option>',
      '<option value="misc/swissprot">Swissprot 完整註解蛋白質資料庫 (Swissprot)</option>',
      '</optgroup>'
 );
  
}

