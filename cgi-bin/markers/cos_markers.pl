use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('cos_markers.html','html2pl converter');
$page->header('保守直系同源標記集 (COS) 標記 (Conserved Ortholog Set markers)');
print<<END_HEREDOC;

  <center>
    

    <table summary="" width="720" cellpadding="0" cellspacing="0"
    border="0">
      <tr>
        <td>
          <center>
            <h3>保守直系同源標記集 (COS) 標記 (Conserved Ortholog Set markers)</h3>
          </center>

          <p>我們採用計算生物學方法，將番茄 EST 資料庫與阿拉伯芥基因組序列進行比對篩選，以尋找一組高度保守的單複製基因，作為番茄與阿拉伯芥基因組之間比較圖譜定位的標記。目前我們已鑑定出約 1,000 個此類保守直系同源標記集 (COS) 標記。<br /></p>

          <p>在 SGN 的此專區中，您將找到每個 COS 標記的序列與選殖株資訊，以及它們在阿拉伯芥基因組中相符的對應基因。我們已調查這些 COS 標記並將其中部分標記定位於番茄基因組上，以提供番茄與阿拉伯芥的比較圖譜。這些定位資訊現已發布於 SGN 上。<br /></p>

          <p>由於這些 COS 標記具有高度保守性，它們也可能適用於其他雙子葉植物物種的比較圖譜定位。用於鑑定 COS 標記的計算篩選流程如下所述：</p>

          <ul>
            <li>將番茄 EST 針對阿拉伯芥基因組（具體而言為來自 TAIR 的 BAC 瓦片路徑）進行 TBLASTX 比對</li>

            <li>鑑定單一單一最佳匹配 (&lt; e -15)，介於單一番茄 EST（或關聯 contig）與阿拉伯芥單一 BAC 之間。每個番茄 EST 必須符合以下條件：

              <ul>
                <li>比對到阿拉伯芥序列的顯著性水準達 &lt; e -15</li>

                <li>經判定非為蛋白質結構域的一部分（即多個茄科序列比對到同一個阿拉伯芥區域的情況）</li>

                <li>下一個次佳的阿拉伯芥比對結果顯著性必須明顯較低 (delta e &gt; 10)</li>
              </ul>
            </li>

            <li>通過所有這些條件的 EST 將被歸類為保守直系同源基因 (conserved orthologs)，所有其他序列則被視為潛在的旁系同源基因 (paralogous) 並予以排除。</li>
          </ul><br />

          <h4>COS 標記的功能註解 (Functional annotation of COS markers)</h4>

          <p>COS 標記使用分析當時定義的 MIPS 角色分類進行功能註解。由於功能角色的描述會持續演進，分析中所使用的角色分類及 COS 標記註解副本可在下方查閱：<br /></p>

          <p><a href="/documents/markers/role_categories.txt">COS 標記註解時的 MIPS 角色分類 (MIPS role categories at time of COS marker annotation)</a></p>

          <h4>COS 標記列表（提供線上與純文字格式）(The list of COS markers)</h4>

          <p><a href="/search/markers/cos_list.pl">線上 COS 列表 (COS list online)</a> - 線上格式，包含序列與瓦片路徑連結。<br />
          <a href="/documents/markers/cos_list-old.txt">舊版純文字下載 (Old plain text download)</a> - 純文字格式下載。<br />
          <a href="/documents/markers/cos_list.txt">舊版純文字下載 2 (Old plain text download 2)</a> - 純文字格式下載。
          </p>

          <p><strong>說明 (Note):</strong> 關於上述連結表格中的番茄圖譜位置：</p>

          <ul>
            <li>複製數 (Copy No) 代表 COS 標記在南方墨點法調查中顯示的複製數 - S（單一，Single）為 1-2 個複製，L（低，Low）為 3-4 個複製，M（多個，Multiple）代表 4 個以上複製。</li>

            <li>圖譜位置 (Map position) 代表 COS 標記在番茄：阿拉伯芥共線性圖譜上的定位位置。例如，T1675 的圖譜位置為 01.005，代表第 1 號染色體，距頂端向下 5 cM。大多數 COS 標記僅有一個圖譜位置；若該 COS 標記具有第二個或第三個圖譜位置，則表示有兩個或三個可被定位的對偶基因。</li>
          </ul><br />
          <br />
        </td>
      </tr>
    </table>
    
  </center>
END_HEREDOC
$page->footer();
