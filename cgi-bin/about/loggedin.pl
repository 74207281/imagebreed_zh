
use strict;
use utf8;

use CXGN::DB::Connection;
use CXGN::Login;

CXGN::DB::Connection->verbose(0);
my $dbh = CXGN::DB::Connection->new();

my $login = CXGN::Login->new($dbh);
my %logins = $login->get_login_status();

my %type_names = (
	curator   => '策展人 (Curators)',
	submitter => '提交者 (Submitters)',
	user      => '一般使用者 (Users)',
);

my $summary = "";
foreach(qw/curator submitter user/){
	my $count = $logins{$_};
	$count = 0 if $count eq "none";
	my $name = $type_names{$_} || ucfirst($_) . "s";
	$summary .= "&nbsp;&nbsp;" . $name . ": <b>$count</b>";
}

my $detailed = "";
foreach my $user_type (keys %{$logins{detailed}}) {
	my $name = $type_names{$user_type} || ucfirst($user_type) . "s";
	$detailed .= $name . ": ";
	my @usernames = (keys %{$logins{detailed}->{$user_type}});
	$detailed .= join ", ", @usernames;	
	$detailed .= "<br />";
}

print "Content-Type: text/html; charset=UTF-8\n\n";
print <<HTML;

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>

    <span style="font-size:1.3em"><b>登入統計 (Logins):</b></span> 
	<span style="font-size:1.2em">$summary</span><br /><br />
	$detailed
</body>
</html>

HTML
