#!/usr/bin/perl -w
use strict;
use warnings;
use utf8;

use CXGN::DB::Connection;
use CXGN::Page;
use CXGN::People;
use CXGN::People::Login;

my $page = CXGN::Page->new( "使用者帳號確認 (solpeople User Confirmation)", "Koni" );
my $dbh = CXGN::DB::Connection->new();

my ( $username, $confirm_code ) = $page->get_arguments( "username", "confirm" );
my $sp = CXGN::People::Login->get_login( $dbh, $username );

if ( !$sp ) {
    confirm_failure($page, "找不到使用者名稱 \"$username\" (Username \"$username\" was not found)。");
}

if ( !$sp->get_confirm_code() ) {
    confirm_failure($page, "使用者 <b>$username</b> 不需要確認。此帳號已經確認過 (No confirmation is required for user <b>$username</b>. This account has already been confirmed)。 <p><a href='/user/login?goto_url=%2F'>[登入頁面 (Login Page)]</a></p>");
}

if ( $sp->get_confirm_code() ne $confirm_code ) {
    confirm_failure($page, "確認代碼無效！(Confirmation code is not valid!)\n");
}

$sp->set_disabled(undef);
$sp->set_confirm_code(undef);
$sp->set_private_email( $sp->get_pending_email() );

$sp->store();

$page->header();

print <<EOF;

<p>使用者名稱 <b>$username</b> 確認成功！(Confirmation successful for username <b>$username</b>)</p>

<p><a href="/user/login?goto_url=%2F">[登入頁面 (Login Page)]</a></p>
<br />

EOF

$page->footer();

sub confirm_failure {
    my ($page, $reason) = @_;

    $page->header();

    print <<EOF;

  <p>抱歉，無法處理此確認請求。請檢查完整的確認網址是否已正確貼入瀏覽器中 (Sorry, we are unable to process this confirmation request. Please check that your complete confirmation URL has been pasted correctly into your browser)。</p>

  <p><b>原因 (Reason):</b> $reason</p>

  <br />

EOF

    $page->footer();

    exit 0;
}
