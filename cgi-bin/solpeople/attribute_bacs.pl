use strict;
use warnings;
use utf8;

use CXGN::Page;
use CXGN::DB::Connection;
use CXGN::Login;
use CXGN::Search::CannedForms;

my $dbh = CXGN::DB::Connection->new();
CXGN::Login->new($dbh)->verify_session();
my $page=CXGN::Page->new('歸屬 BAC (Attribute BACs)','john');
$page->header('歸屬 BAC (Attribute BACs)','如何將 BAC 歸屬於定序專案 (How to attribute a BAC to a sequencing project)');
print <<END_HTML;
<ol>
<li>請先使用任何頁面右上角的連結登入 (Log in using the link at the top right of any SGN page)。</li>
<li>從工具列中選擇 <b>搜尋 (Search)</b>-&gt;<b>BAC</b>，或直接使用下方的表單 (From the toolbar, choose search-&gt;BACs, or just use the form below)。</li>
<li>在搜尋框中輸入您要歸屬於定序專案的 BAC 名稱 (Type the name of the BAC you would like to attribute to your sequencing project into the search box)。</li>
<li>點擊 <b>搜尋 (Search)</b> 按鈕 (Click the search button)。</li>
<li>若您在搜尋結果中看到所需的 BAC，請點擊其連結 (If you see the desired BAC in the search results, click its link)。</li>
<li>在 BAC 資訊頁面上，會有一個允許您將 BAC 指派給專案的連結。請注意，您必須登入才能看到此連結。請確保歸屬設定正確，因為錯誤的歸屬只能由人員手動移除 (On the BAC information page, there should be a link which will allow you to assign the BAC to your project. Note that you must be logged in for this link to be visible. Please be sure that you are making a correct attribution, because incorrect attributions can only be removed manually by the SGN staff)。</li>
</ol>
END_HTML
print CXGN::Search::CannedForms::clone_search_form($page);
$page->footer();
