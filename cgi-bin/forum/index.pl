use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('關於論壇 (About The SOL Forum)');
print<<END_HEREDOC;

<center>
    

  <table summary="" width="720" cellpadding="0" cellspacing="0"
  border="0">
    <tr>
      <td>
        <center>
          <h3>論壇 (SOL Forum)</h3>
        </center>
     
      <h4>論壇簡介 (What it is)</h4>
      <p>SOL 論壇是專為 <a href="/">Sol Genomics Network</a> 註冊使用者提供的互動式討論板。已註冊使用者可在 <a href="/search/direct_search.pl?search=directory">SGN 名錄資料庫 (people directory)</a> 中查詢。在您 <a href="/solpeople/new-account.pl">註冊 (register)</a> 之前，請先確認您是否 <a href="/search/direct_search.pl?search=directory">已在資料庫中 (already in the database)</a>。
      </p>
      <p>
      除了討論板外，亦設有 <a href="http://rubisco.sgn.cornell.edu/mailman/listinfo/sol-forum">SOL Forum 郵件列表 (SOL Forum mailing list)</a> 供訂閱者交流。發布於郵件列表上的訊息不會出現在討論板上，僅由訂閱者接收。只有成員才能發文，以防止垃圾訊息。
      </p>
      <h4>如何使用 (How to use it)</h4>
      <p>
      您可以依主題 <a href="topics.pl">瀏覽 (browse)</a> 討論板。若要建立新主題或發布留言，請先 <a href="/user/login">登入 (log in)</a>。
      </p>
      
      <h4>主題 (Topics)</h4>
      <div class="boxbgcolor5"><b>注意事項 (Please note)</b> <ul><li>此服務由 SGN 免費提供。SGN 保留隨時因任何原因移除主題與貼文的權利 (This service is provided by SGN as a courtesy. SGN reserves the right to remove topics and posts for any reason at any time)。</li>
      <li>此服務為實驗性質，可能會在不另行通知的情況下隨時修改或移除。</li>
      </ul>
      </div>
      
<br />
      論壇主題 (Forum topics): 
      <ul>
      <li><a href="posts.pl?topic_id=2">工作職缺 (Job Postings)</a></li>

      <li><a href="topics.pl">完整主題列表 (Complete list of topics)</a></li>
      </ul>

      </td>
    </tr>
  </table><!-- begin footer include -->
  
  <!-- end footer include -->
</center>
END_HEREDOC
$page->footer();
