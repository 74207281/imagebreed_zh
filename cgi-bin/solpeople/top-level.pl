#DEPRECATED
#####################
#This page now points to the url /solpeople/profile/<sp_person_id> in the controller SGN::Controller::People
#####################

use strict;
use utf8;

use CXGN::DB::Connection;
use CXGN::Page;
use CXGN::Login;
use CXGN::People;
use CXGN::People::Person;
use CXGN::BlastWatch;
use CXGN::Phenome::Locus;
use CXGN::Cview::MapFactory;
use CXGN::Page::FormattingHelpers qw/info_section_html page_title_html
  info_table_html simple_selectbox_html
  html_optional_show columnar_table_html/;

our $c;
use CatalystX::GlobalContext qw($c);


my $page = CXGN::Page->new( "Solpeople 主選單 (solpeople main menu)", "john" );
my $dbh = CXGN::DB::Connection->new();
my $site_name = $c->config->{project_name};

my $sp_person_id = CXGN::Login->new($dbh)->verify_session();

my $sp = CXGN::People::Person->new( $dbh, $sp_person_id );
unless ($sp_person_id) {
    $page->error_page( "Login ID not found.",
        "", "", "Login ID not found: $sp_person_id" );
}
unless ( $sp->get_username() ) {
    $page->error_page( "Username not found.",
        "", "", "Username not found for sp_person_id '$sp_person_id'" );
}
my $username = $sp->get_first_name() . " " . $sp->get_last_name();

#my $research_update=$sp->get_research_update();
#my $contact_update=$sp->get_contact_update();

$page->add_style( text => <<EOS);
div#queryTable
{
margin: 0px 0px 0px 0px;
display: none;
}
EOS
$page->header();

print <<END_HTML;

<script type = "text/javascript">
<!--
    function toggleLayer(whichLayer) {
	if (document.getElementById) {
	    var style2 = document.getElementById(whichLayer).style;
	    style2.display = style2.display? "":"block";
	}
	else if (document.all) {
	    var style2 = document.all[whichLayer].style;
	    style2.display = style2.display? "":"block";
	}
	else if (document.layers) {
	    var style2 = document.layers[whichLayer].style;
	    style2.display = style2.display? "":"block";
	}
    }
    function showSequence(sequence) {
	document.getElementById("Heading").innerHTML="<strong>Full sequence: </strong>";
	document.getElementById("fullSequence").innerHTML=sequence;
    }
    function hideSequence() {
	document.getElementById("Heading").innerHTML="";
	document.getElementById("fullSequence").innerHTML="";
    }
//-->
</script>
END_HTML

print page_title_html("我的 $site_name (My $site_name)");
print qq|<div align="center">歡迎 <b>$username</b> (Welcome <b>$username</b>)</div>\n|;
print
qq|<div align="right" style="margin-bottom: 0.5em">不是 $username？(Not $username?) <a href="login.pl?logout=yes">[登出 (log out)]</a></div>\n|;
print info_section_html( title => '一般工具 (General Tools)', contents => <<EOHTML);
    <a href="personal-info.pl?action=edit&sp_person_id=$sp_person_id">檢視或更新個人資訊（聯絡與研究）(View or update personal (contact and research) information)</a><br />
    <a href="change-account.pl?action=edit&sp_person_id=$sp_person_id">更新帳號資訊 (Update account information)</a><br />
    <a href="/forum/topics.pl">在論壇發文 (Post to SGN forum)</a><br />
EOHTML

# my $queries =
#     qq|<div id="queryTable">|
#   . CXGN::BlastWatch::get_queries( $dbh, $sp_person_id )
#   . '</div>';
# print info_section_html( title => 'BLAST Watch', contents => <<EOHTML);
#     <div style="margin-bottom: 1em">BLAST Watch is an SGN service that lets users submit recurring BLAST queries to SGN.  Our software repeats your BLAST search every week and notifies you by email if the BLAST results change.</div>
#     <a href="/tools/blast/watch/index.pl">Submit a query to SGN BLAST Watch</a><br />
#     <a href="javascript:toggleLayer('queryTable');" title="View your BLAST Watch queries">View your BLAST Watch queries</a>
#     $queries
# EOHTML

#return 1 if the first term is eq to one of the other terms given
sub in(@) {
    my $t = shift;
    ( grep { $t eq $_ } @_ ) ? 1 : 0;
}

#now assemble the sequencing tools stuff
if ( in( $sp->get_user_type, qw/curator sequencer/ ) ) {

    #make a form for uploading TPF and AGP files
    my $tpf_agp_upload = do {
        if ( $sp->get_user_type eq 'curator' ) {
            tpf_agp_upload_forms(<<EOHTML);
      <!-- the string 'TYPE' will be replaced in each instance by tpf_agp_upload_forms() -->
<label for="chrnuminputTYPE">染色體編號 (For Chromosome #): </label><input id="chrnuminputTYPE" name="chr" type="text" size="2" maxlength="2" />
EOHTML
        }
        elsif ( $sp->get_user_type eq 'sequencer'
            and my @projects =
            grep { $_ >= 1 && $_ <= 12 }
            $sp->get_projects_associated_with_person )
        {
            my $chrinput =
              @projects > 1
              ? simple_selectbox_html(
                name    => 'chr',
                choices => \@projects,
                label   => '染色體編號 (For Chromosome #):',
              )
              : qq|染色體編號 (For Chromosome #): <b>$projects[0]</b> <input type="hidden" value="$projects[0]" name="chr" />|;
            tpf_agp_upload_forms($chrinput);
        }
    };

    print info_section_html( title => '定序人員工具 (Sequencer Tools)', contents => <<EOHTML);
<a href="attribute_bacs.pl">將 BAC 歸屬於您的染色體定序專案 (Attribute a BAC to your chromosome sequencing project)</a><br />
<div style="vertical-align: middle; font-weight: bold"></div>
$tpf_agp_upload
EOHTML
}

# if( in( $sp->get_user_type(), qw/submitter curator/ ) )
# {
#   print info_section_html(title => 'EST Submission Pages', contents => <<EOHTML);
# <a href="/data-submit/top-level.pl">Data submission start page</a>
# EOHTML
# }

if ( in( $sp->get_user_type(), qw/submitter curator/ ) ) {
    print info_section_html( title => 'QTL 資料提交 (QTL data submission)',
        contents => <<EOHTML);
<a href="/phenome/qtl_form.pl">上傳並分析您的 QTL 資料 (Upload and analyse your QTL data)</a>
EOHTML
}

my @pops = CXGN::Phenome::Population->my_populations($sp_person_id);

if (@pops) {
    my $pop_list = my_populations(@pops);
    print info_section_html( title => '族群 (Populations)', contents => $pop_list );
}

if ( $sp->get_user_type() eq 'curator' ) {
    print info_section_html( title => '管理者工具 (Curator Tools)', contents => <<EOHTML);
<a href="/solpeople/admin/crash_test.pl">測試網站錯誤處理 (Test website error handling)</a><br />
<a href="/solpeople/admin/stats.pl">檢視使用者統計 (View user stats)</a><br />
<a href="/solpeople/admin/quick_create_account.pl">建立新使用者帳號 (Create new user account)</a><br />
<a href="/solpeople/admin/create_organization.pl">建立新機構/組織 (Create new organization)</a>
EOHTML
}

if ( $sp->get_user_type() =~ /curator/i ) {
    my $publications =
qq| <a href= "/search/pub_search.pl">搜尋出版文獻資料庫 (Search publication database)</a><br />|;
    $publications .=
qq| <a href= "/search/pub_search.pl?w9b3_assigned_to=$sp_person_id">查看指派給您的文獻 (See your assigned publications)</a><br />|;
    $publications .=
qq| <a href= "/search/pub_search.pl?w9b3_status=pending">查看待審核文獻 (See publications pending curation)</a><br />|;
    $publications .=
qq| <a href= "/chado/fetch_pubmed.pl">從 PubMed 匯入新文獻 (Load new publications from PubMed)</a><br />|;

    print info_section_html(
        title    => '文獻探勘 (Literature mining)',
        contents => $publications
    );
}

if ( $sp->get_user_type() =~ /submitter|curator|sequencer/i ) {

    my @loci =
      CXGN::Phenome::Locus::get_locus_ids_by_editor( $dbh, $sp_person_id );
    my $top  = 50;
    my $more = 0;
    my $max  = @loci;
    if ( @loci > 24 ) {
        $more = @loci - 24;
        $max  = 24;
    }

    my $locus_editor_info = qq { 無 (None)。<br /> };
    if ( @loci > 0 ) {
        $locus_editor_info = "";
    }

    for ( my $i = 0 ; $i < ($max) ; $i++ ) {
        my $locus    = CXGN::Phenome::Locus->new( $dbh, $loci[$i] );
        my $symbol   = $locus->get_locus_symbol();
        my $locus_id = $locus->get_locus_id();

        $locus_editor_info .=
qq { <a href="/phenome/locus_display.pl?locus_id=$locus_id&amp;action=view">$symbol</a> };
    }
    if ($more) {
        $locus_editor_info .=
qq|<br><b>以及另外 <a href="/search/locus/>$more 個 (and $more more)</a></b><br />|;
    }

    print info_section_html(
        title    => '具有編輯權限的基因位點 (Loci with Editor Privileges)',
        contents => $locus_editor_info
    );

    my @annotated_loci =
      CXGN::Phenome::Locus::get_locus_ids_by_annotator( $dbh, $sp_person_id );

    my $more = 0;
    my $max  = @annotated_loci;
    if ( @annotated_loci > 24 ) {
        $more = @annotated_loci - 24;
        $max  = 24;
    }

    my ( $locus_annotations, $more_annotations );

    for ( my $i = 0 ; $i < $top ; $i++ ) {
        my $locus    = CXGN::Phenome::Locus->new( $dbh, $annotated_loci[$i] );
        my $symbol   = $locus->get_locus_symbol();
        my $locus_id = $locus->get_locus_id();

        if ( $i < $max ) {
            $locus_annotations .=
qq | <a href="/locus/$locus_id/view">$symbol</a> |;
        }
        else {
            $more_annotations .=
qq { <a href="/locus/$locus_id/view">$symbol</a> };
        }
    }

    if ($more) {
        $locus_annotations .= " 以及另外 $more 個，未顯示 (and $more more, not shown)。<br />";

        $locus_annotations .=
          html_optional_show( 'locus_annotations', '顯示更多 (Show more)',
            qq|<div class="minorbox">$more_annotations</div> |,
          );
    }

    $locus_annotations .=
qq| <a href="../phenome/recent_annotated_loci.pl">[依日期檢視已註釋基因位點 (View annotated loci by date)]</a> |;
    print info_section_html(
        title    => '已註釋基因位點 (Annotated Loci)',
        contents => $locus_annotations
    );

    my $map_factory = CXGN::Cview::MapFactory->new($dbh);
    my @user_maps   = $map_factory->get_user_maps();
    my $html        = "";

    if ( @user_maps > 0 ) {
        $html .=
"<table alt=\"\" ><tr><td><i>名稱 (Name)</i></td><td></td><td></td><td><i>狀態 (Status)</i></td></tr>";
        foreach my $um (@user_maps) {
            my $public = " (未公開 / not public) ";
            if ( $um->get_map()->get_is_public() ) { $public = "(公開 / public)"; }
            $html .=
                "<tr><td><b>"
              . $um->get_short_name()
              . "</b></td><td> <a href=\"/cview/umap.pl?action=view&amp;user_map_id="
              . $um->get_id()
              . "\" >[檢視 (view)]</a></td><td><a href=\"/cview/umap.pl?action=edit&amp;user_map_id="
              . $um->get_id()
              . "\">[設定 (configure)]</a></td><td>$public</td></tr>";

        }
        $html .= "</table>";
    }

    # BROKEN!
    #    print info_section_html(title => 'User Maps', contents=> <<EOHTML);
    #    <a href="/cview/upload_usermap.pl">Upload new user map</a><br />
    #	<br />
    #	$html
    #EOHTML

}

my $user_type = $sp->get_user_type();
my $user_info = {
    user => qq{ 您目前的使用者狀態為 <b>$user_type</b> (Your current user status is <b>$user_type</b>)。如需升級為擁有更多權限的 <b>提交者 (submitter)</b> 帳號，請聯絡 <a href="mailto:sgn-feedback\@sgn.cornell.edu">SGN</a>。提交者可以上傳使用者地圖、EST 資料，並成為基因位點編輯者。 },

    submitter => qq{ 您目前的使用者狀態為 <b>$user_type</b> (Your current user status is <b>$user_type</b>)。您擁有系統上的最高使用者權限。如果您想變更使用者狀態，請聯絡 <a href="mailto:sgn-feedback\@sgn.cornell.edu">SGN</a>。},

    curator => qq{ 您目前的使用者狀態為 <b>$user_type</b> (Your current user status is <b>$user_type</b>)。 },

    sequencer => qq{ 您目前的使用者狀態為 <b>$user_type</b> (Your current user status is <b>$user_type</b>)。您擁有系統上的最高使用者權限。 },

    genefamily_editor => qq{ 您目前的使用者狀態為 <b>$user_type</b> (Your current user status is <b>$user_type</b>)。 },
};

print info_section_html( title => '使用者狀態 (User Status)',
    contents => $user_info->{$user_type} );

$page->footer();

#returns a string containing a TPF and an AGP upload form,
#with the single argument interpolated in
sub tpf_agp_upload_forms {
    my $chrinput = shift;
    my ( $chrinput_agp, $chrinput_tpf ) = ( $chrinput, $chrinput );
    $chrinput_agp =~ s/TYPE/_agp/g;
    $chrinput_tpf =~ s/TYPE/_tpf/g;
    return <<EOHTML;
EOHTML
}

sub my_populations {
    my @pops = @_;
    my $pops_list;

    foreach my $pop (@pops) {
        my $pop_name  = $pop->get_name();
        my $pop_id    = $pop->get_population_id();
        my $is_public = $pop->get_privacy_status();
        if ($is_public)    { $is_public = '公開可用 (publicly available)'; }
        if ( !$is_public ) { $is_public = '尚未公開 (not publicly available yet)'; }
        $pops_list .=
qq |<a href="/qtl/population/$pop_id">$pop_name</a> <i>($is_public)</i><br/>|;
    }

    return $pops_list;
}
