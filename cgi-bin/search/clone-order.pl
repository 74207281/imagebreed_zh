#!/usr/bin/perl -w
use strict;
use utf8;
use CXGN::Page;
use CXGN::DB::Connection;
use CXGN::Cookie;
my $dbh = CXGN::DB::Connection->new();
my $check_q = $dbh->prepare("SELECT order_routing_id from clone LEFT JOIN library USING (library_id) where clone_name=?");

our $page = CXGN::Page->new("選殖株購物車 (Clone Shopping Cart)", "Koni");

my ($clone_add) = $page->get_arguments("add_clone");

my $cart_contents = CXGN::Cookie::get_cookie("CloneCart");

if (!$cart_contents) {
  $cart_contents = "";
}

my @clones = split /,/,$cart_contents;
if ($clone_add) {
  push @clones, $clone_add;
}

# Note: An advantage of server-side statefulness here is not repeating this
#       everytime. This is typical of stateful/stateless tradeoff -- storing
#       state provides performance gains but at the expense of correctness and
#       increased complexity.
#
#       Future versions of this ordering thing may require server side state
#       due to the limitations of cookie size at the client.
my %ok_clones = ();
my %orders = ();
foreach my $clone_id ( @clones ) 
{
  $check_q->execute($clone_id);
  if ($check_q->rows()>0) {
    my ($order_routing_id) = $check_q->fetchrow_array();
    if (!$ok_clones{$clone_id}) {
      push @{$orders{$order_routing_id}}, $clone_id;
      $ok_clones{$clone_id} = 1;
    }
  }
}

# If we have valid clones, set the cookie.
if (keys(%ok_clones) > 0) {
  CXGN::Cookie::set_cookie("CloneCart",join(",",keys(%ok_clones)));
} else {
  CXGN::Cookie::set_cookie("CloneCart","");
  empty_cart();
}

if ($clone_add) {
  $page->client_redirect("/search/clone-order.pl");
  exit(0);
}

my @order_text = ();
foreach my $routing_id ( keys %orders ) {
  if ($routing_id == 1) { # TED
      push @order_text, ted_order_routing($orders{$routing_id});
  }
  elsif ($routing_id == 2) { # Kazusa
      push @order_text, kazusa_order_routing($orders{$routing_id});
  } else {
    $page->error_page("Clone ordered but order routing function for \"$routing_id\" is not available");
  }

}

sub ted_order_routing {
  my ($clone_listref) = @_;
  my $clone_order = join(",",@{$clone_listref});
  my $text = <<EOF;
  <form method="post" action="/search/route-order.pl" target="_BLANK">
<input type="hidden" name="route_to" value="1" />
<input type="hidden" name="order_clones" value="$clone_order" />
<table summary="" cellpadding="2" cellspacing="2" border="0" align="center" width="100%">
<tr><td style="background-color: #CCCCFF;" align="center">以下選定的選殖株可透過 <b>TED</b> 取得 (The following selected clones are available through TED)：</td></tr>
EOF
  foreach (@{$clone_listref}) {
    $text .= "<tr><td>$_</td></tr>";
  }

  $text .= <<EOF;
<tr><td style="background-color: #CCCCFF;" align="center">
<input type="submit" name="route_order" value="轉送訂單 (Route Order)" />&nbsp;&nbsp;<input type="submit" name="route_order" value="刪除訂單 (Delete Order)" />
</td></tr></table></form>
EOF

  return $text;
}

sub kazusa_order_routing { 
    my ($clone_listref) = @_;
    my $clone_order = join(",", @{$clone_listref});
    my $clone_order_text = "Dear Kazusa, %0AI would like to order the following clones:%0A$clone_order%0A";
    my $text = <<EOF;
<form method="post" action="/search/route-order.pl" target="_BLANK">
<input type="hidden" name="route_to" value="1" />
<input type="hidden" name="order_clones" value="$clone_order" />
<table summary="" cellpadding="2" cellspacing="2" border="0" align="center" width="100%">
<tr><td style="background-color: #CCCCFF;" align="center">以下選定的選殖株可透過 <b>Kazusa</b> 取得 (The following selected clones are available through Kazusa)：</td></tr>
EOF
  foreach (@{$clone_listref}) {
    $text .= "<tr><td>$_</td></tr>";
  }

  $text .= <<EOF;
<tr><td style="background-color: #CCCCFF;" align="center">
<a href="mailto:plantinfo\@kazusa.or.jp?subject=clone order&amp;body=$clone_order_text"><b>訂購選殖株 (電子郵件) / ORDER CLONES (email)</b></a>&nbsp;&nbsp;<input type="submit" name="route_order" value="刪除訂單 (Delete Order)" /><br /><br />
<a href="http://www.kazusa.or.jp/clonereq/">Kazusa 選殖株申請頁面 (Kazusa Clone request page)</a> | <a href="http://www.kazusa.or.jp/clonereq/agreement.html">Kazusa 材料轉移協議 (MTA)</a>
</td></tr></table></form>

EOF
return $text;
}

$page->header();

print <<EOF;

<table summary="" width="80%" align="center" cellspacing="2" cellpadding="2" border="0">
<tr><td>
<p>當您完成選殖株挑選後，SGN 可為您匯總欲訂購的選殖株清單，並將訂單轉送給相應的人員或機構。若要繼續挑選選殖株，請使用瀏覽器的返回按鈕或開始一個<a href="/search/direct_search.pl">新搜尋 (New Search)</a>。</p>
</td></tr>
<tr><td align="center"><b>購物車內容 (Shopping Cart Contents)</b></td></tr>
<tr><td>
<p />
@order_text
</td></tr>
<tr><td>
<p>
<b>請注意 (Please Note)：</b>SGN 不直接處理選殖株訂單。選取的選殖株將透過上方按鈕在線上轉送給相應機構。您的瀏覽器<b>必須支援 Cookie</b> 才能正常運作。請使用瀏覽器的返回按鈕繼續選取選殖株，或使用上方連結開始新搜尋。
</p>
</td></tr>
</table>
EOF

$page->footer();

sub empty_cart {

  $page->header();

  print <<EOF;

  <table summary="" border="0" width="80%" align="center">
  <tr><td align="center"><p>您的購物車中沒有 cDNA 選殖株 (There are no cDNA clones in your shopping cart)。</td></tr>
  <tr><td align="center"><p>請注意，您的瀏覽器必須接受 Cookie 才能透過 SGN 訂購選殖株 (Browser must accept cookies)。</p>
  <br /></td></tr>
  </table>

EOF

  $page->footer();

  exit 0;
}

