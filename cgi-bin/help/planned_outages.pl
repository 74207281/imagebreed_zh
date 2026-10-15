use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new("預定停機維護 (Scheduled outage)","Marty");
$page->header();
print <<END_HEREDOC;

<div>
  <h1>SGN 及相關專案預定停機服務維護 (Scheduled service downtime for SGN and related projects)</h1>

  <p>
    我們將於 2006 年 4 月 3 日當週將伺服器移至新機房。以下服務將於 2006 年 4 月 5 日（週三）至 2006 年 4 月 7 日（週五）暫停提供 (We are moving our servers to a new room during the week of April 3, 2006. The following services will be unavailable from Wednesday April 5, 2006 to Friday, April 7, 2006)：
</p>

    <ul>
      <li>FTP 下載 (ftp downloads)</li>
      <li>BAC 提交 (BAC submissions)</li>
      <li>網站登入 (website login)</li>
      <li>EST 上傳 (EST uploads)</li>
      <li>郵件論壇 (mailing lists: sgn-feedback 及其他)</li>
    </ul>

<p>
    此外，我們的網站（sgn.cornell.edu, pgn.cornell.edu）在這些日子可能會有短暫時間無法存取 (Additionally, our websites may be unavailable for short periods during these days)。
  </p>

  <p>
    若排程有所變動，我們將更新此頁面以反映修改後的計畫。請查看此處以獲取後續公告 (In case our schedule should change, we will update this page to reflect our modified plans. Please check here for further announcements)。
  </p>

    <h4>伺服器遷移照片 (Photos from the server move)</h4>
    <a href="/static_content/sgn_photos/server_move_2006/P1010103.jpg"><img src="/static_content/sgn_photos/server_move_2006/thumbs/P1010103.jpg" style="margin: 2px; float: left;" alt="" /></a>

    <a href="/static_content/sgn_photos/server_move_2006/P1010112.jpg"><img src="/static_content/sgn_photos/server_move_2006/thumbs/P1010112.jpg" style="margin: 2px; float: left;" alt="" /></a>

    <a href="/static_content/sgn_photos/server_move_2006/P1010115.jpg"><img src="/static_content/sgn_photos/server_move_2006/thumbs/P1010115.jpg" style="margin: 2px; float: left;" alt="" /></a>

    <a href="/static_content/sgn_photos/server_move_2006/P1010118.jpg"><img src="/static_content/sgn_photos/server_move_2006/thumbs/P1010118.jpg" style="margin: 2px; float: left;" alt="" /></a>

    <a href="/static_content/sgn_photos/server_move_2006/P1010129.jpg"><img src="/static_content/sgn_photos/server_move_2006/thumbs/P1010129.jpg" style="margin: 2px; float: left;" alt="" /></a>

    <a href="/static_content/sgn_photos/server_move_2006/P1010131.jpg"><img src="/static_content/sgn_photos/server_move_2006/thumbs/P1010131.jpg" style="margin: 2px; float: left;" alt="" /></a>

    <a href="/static_content/sgn_photos/server_move_2006/P1010132.jpg"><img src="/static_content/sgn_photos/server_move_2006/thumbs/P1010132.jpg" style="margin: 2px; float: left;" alt="" /></a>

    <a href="/static_content/sgn_photos/server_move_2006/P1010134.jpg"><img src="/static_content/sgn_photos/server_move_2006/thumbs/P1010134.jpg" style="margin: 2px; float: left;" alt="" /></a>

    <a href="/static_content/sgn_photos/server_move_2006/P1010135.jpg"><img src="/static_content/sgn_photos/server_move_2006/thumbs/P1010135.jpg" style="margin: 2px; float: left;" alt="" /></a>


</div>

END_HEREDOC


$page->footer();
