use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('index.html','html2pl converter');
$page->header('SGN 分子標記 (SGN Markers)');
print<<END_HEREDOC;

  
     

     <br />
     <center>
     <table summary="" class="boxbgcolor2" width="100\%">
     <tr>
     <td width="25\%">&nbsp;</td>
     <td width="50\%" class="left">
	  <div class="boxcontent">
	  <br />
	    
	    <div class="subheading">
	    <u>SGN 分子標記 (SGN Markers)</u> 
	    </div>
	    <div class="boxsubcontent">
            <a href="/markers/cos_markers.pl">保守直系同源標記集 (COS) 標記 (Conserved Ortholog Set Markers)</a> - 在 SGN 的此專區中，您將找到每個 COS 標記的序列與選殖株資訊，以及它們在阿拉伯芥基因組中相符的對應基因。我們已調查這些 COS 標記並將其中部分標記定位於番茄基因組上，以提供番茄與阿拉伯芥的比較圖譜。這些定位資訊現已發布於 SGN 上。
	    </div>
	    <div class="boxsubcontent">
	    <a href="/markers/cosii_markers.pl">第二代保守直系同源標記集 (COSII) 標記 (Conserved Ortholog Set II Markers)</a> - 在 SGN 的此專區中，您將找到每個 COSII 基因的序列資訊以及已定位 COSII 基因（即所謂的 COSII 標記）的定位資訊。我們已在番茄中定位了超過 100 個 COSII 標記，未來將定位更多（至少 500 個），同時這些 COSII 標記也將定位於主要茄科物種（如茄子、甜椒、菸草等）中。隨著新數據的產出，本專區的所有資訊將持續更新，歡迎隨時回訪查閱。
	    </div>
	    <div class="boxsubcontent">
	    <a href="/markers/microsats.pl">微衛星 (SSR) 標記 (Microsatellites / SSRs)</a> - 雖然微衛星或簡單重複序列 (SSR) 通常出現在基因組的非編碼區，但它們也可能出現在 EST 的 3' 或 5' UTR，甚至是編碼區（通常為三核苷酸重複）。詳情請參閱此頁面。
	    </div> 
              
          </div>
</td>
<td width="25\%">&nbsp;</td>
</tr>
</table>
</center>

END_HEREDOC
$page->footer();