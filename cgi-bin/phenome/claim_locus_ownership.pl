
use strict;
use warnings;
use utf8;

use CXGN::Page;
use CXGN::Login;
use CXGN::People;
use CXGN::Contact;
use CXGN::Phenome::Locus;

use CatalystX::GlobalContext qw( $c );

my $dbh = $c->dbc->dbh;

my $page=CXGN::Page->new("claim_locus_ownership.pl","Naama");
my %args=$page->get_all_encoded_arguments();
my $locus_id=$args{locus_id};
my $locus=CXGN::Phenome::Locus->new($dbh, $locus_id); 
my $sp_person_id = CXGN::Login->new($dbh)->verify_session();

my @owners= $locus->get_owners();

my $user = CXGN::People::Person -> new($dbh, $sp_person_id);
if ((grep { $_ =~ /^$sp_person_id$/ } @owners) ) {
    $page->header();
    print <<HEREDOC;
    
<h3>您已經是該基因座的擁有者 (You are already the owner of the locus)。<br>
    下次您可以點選每個 SGN 頁面右上角的「登入 (login)」連結。<br><br>
<a href="/locus/$locus_id/view">返回 (Go back)</a> 基因座頁面。</h3> 

HEREDOC
    $page->footer();
    exit();
}

my $username=$user->get_first_name()." ".$user->get_last_name();
my $usermail=$user->get_private_email();
my $replyto= 'sgn-feedback@sgn.cornell.edu';


my $subject="[Locus ownership] Request editor privileges for locus $locus_id";
my $fdbk_body="$username has requested to obtain ownership for locus $locus_id\nsp_person_id = $sp_person_id, $usermail";


my $user_body= "Dear $username,\n\nYour request for obtaining editor privileges for SGN locus ID $locus_id will be processed shortly.\nA confirmation email will be sent to you once the request is confirmed. After that you should be able now to edit this locus' details.\n\n Thank you for using SGN!\nhttp://www.sgn.cornell.edu/"; 



$page->header();

if ($args{action} eq 'confirm') {
    confirm_dialog($locus_id);
}
elsif ($args{action} eq 'request') {

    print <<END_HEREDOC;

您對基因座 ID: $locus_id 的編輯權限申請<br /> 
已發送至 SGN 開發團隊。<br /><br />
我們將盡快回覆您。<br /><br />

<a href="locus_display.pl?locus_id=$locus_id">返回 (Go back)</a> 基因座頁面。 


END_HEREDOC
CXGN::Contact::send_email($subject,$fdbk_body, 'sgn-db-curation@sgn.cornell.edu');
CXGN::Contact::send_email($subject,$user_body, $usermail, $replyto);
}

$page->footer();


sub confirm_dialog {

    #my $self = shift;
   
    my $locus_id = shift;
    my $back_link = qq| <a href="locus_display.pl?locus_id=$locus_id">返回 (Go back)</a> 基因座頁面（不申請編輯權限）|;


    print qq { 	
	<form>
	申請基因座 ID: $locus_id 的編輯權限？(Request edit privileges for locus id: $locus_id?) 
	<input type="hidden" name="action" value="request" />
	<input type="hidden" name="locus_id" value="$locus_id" />
	<input type="submit" value="送出申請 (Submit request)" />
	</form>
	
	$back_link

    };

}

   
