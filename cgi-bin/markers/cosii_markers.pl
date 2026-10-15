use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('cosii_markers.html','html2pl converter');
$page->header('第二代保守直系同源標記集 (COSII) 標記 (Conserved Ortholog Set II (COSII) markers)');
print<<END_HEREDOC;

  <center>
    

    <table summary="" width="100\%" cellpadding="0" cellspacing="0"
    border="0">
      <tr>
        <td>
          <center>
            <h3>第二代保守直系同源標記集 (COSII) 標記 (Conserved Ortholog Set II (COSII) markers)</h3>
          </center>

          <p>COSII 標記是基於 PCR 的分子標記，開發自菊類 (Asterid) 物種中的一組單複製保守直系同源基因 (COSII 基因)。每個 COSII 基因（代表一組菊類 unigene）僅與單一單複製阿拉伯芥基因相匹配。與 Fulton 等人 (2002) 回報的 COS 標記相比，COSII 標記/基因具有以下新特性：</p>

          <ol>
            <li>對多個由 EST 組裝的 unigene 資料庫（番茄、馬鈴薯、甜椒和咖啡）以及阿拉伯芥 CDS 資料庫進行了計算篩選，建立直系同源性的方法更為穩健。</li>

            <li>親緣關係分析支持將其歸類為直系同源基因。</li>

            <li>它們在這些物種中以單複製基因的形式存在。</li>

            <li>設計的「通用引子 (Universal Primers)」能夠從其他相關茄科物種（包括缺乏序列數據的物種）中增幅直系同源對應片段（外顯子及/或內含子）。</li>
          </ol>

          <p>因此，這組 COSII 基因以及通用引子是建立茄科與阿拉伯芥之間共線性網絡，以及闡明茄科系統發育、基因組演化和基因組組織架構的強大工具。此外，研究人員還可以為其他植物科（特別是雙子葉植物）建立類似的直系同源基因集和通用引子，並透過共同的阿拉伯芥直系同源基因將其與 COSII 基因連結。</p>

          <p>鑑定 COSII 基因的計算篩選流程請參閱<a href="/documents/img/cosii.png">此流程圖 (this diagram)</a>。</p>

          <p>在 SGN 的此專區中，您將找到每個 COSII 基因的序列資訊以及已定位 COSII 基因（即所謂的 COSII 標記）的定位資訊。我們已在番茄中定位了超過 300 個 COSII 標記，未來將定位更多（至少 500 個），同時這些 COSII 標記也將定位於主要茄科物種（如茄子、甜椒、菸草等）中。隨著新數據的產出，本專區的所有資訊將持續更新，歡迎隨時回訪查閱。</p>

          <h4>從 COSII 基因開發的通用引子 (iUPA 與 eUPA) (Universal Primers developed from COSII genes)</h4>

          <p><em>菊類物種通用引子</em> (Universal Primers for Asterid species, UPA) 是根據 COSII 基因/群組的共識序列設計的，在大部分（若非全部）茄科物種及雙子葉植物菊類 I 分支 (Asterid I clade) 的相關分類群中，均可增幅外顯子和內含子區域，因此對於比較圖譜定位與親緣關係學非常有用。</p>

          <p><em>內含子 UPA</em> (iUPA) 可增幅內含子及其側翼外顯子的短片段，因此適用於近緣物種的基因組/比較圖譜定位與親緣關係學研究。許多 iUPA 已在各種茄科物種以及咖啡中進行過測試，引子序列、PCR 條件和產物大小均已提供。</p>

          <p><em>外顯子 UPA</em> (eUPA) 可增幅至少 400 bp 的外顯子序列（含或不含中間的內含子），因此適用於遠緣物種的親緣關係學研究。部分 eUPA 已在各種茄科物種以及咖啡中進行過測試，引子序列、PCR 條件和產物大小均已提供。</p>

          <h4>如何閱讀 COSII 標記資訊頁面 (How to read COSII marker information pages)</h4>

          <p>阿拉伯芥 CDS 未經編輯。Unigene 根據其與 CDS 的比對進行了編輯（修剪 UTR 並校正定序錯誤）。胜肽序列是由編輯後序列的 frame 1 轉譯而來（針對 unigene），或從 <a href="http://www.arabidopsis.org">TAIR</a> 下載（針對阿拉伯芥）。Unigene 的內含子位置是根據與阿拉伯芥 CDS 的比對預測而得，其內含子位置自 <a href="http://www.arabidopsis.org">TAIR</a> 下載。「=====」表示來自 <a href="http://www.arabidopsis.org">TAIR</a> 的內含子（阿拉伯芥）或序列中預測的內含子位置（unigene）。</p>

          <h4>COSII 基因的功能註解 (Functional annotation of COSII genes)</h4>

          <p>每個 COSII 基因均根據相符阿拉伯芥基因成員的<a href="http://www.arabidopsis.org/info/ontologies/go/">基因本體論 (Gene Ontology, GO) 註解</a>指定功能註解。</p>

          <h4>在主要茄科物種中定位基於 PCR 的 COSII 標記 (Mapping PCR-based COSII markers in major solanaceous species)</h4>

          <p>所有已定位的 COSII 標記均可在這些<a href="/search/markers/markersearch.pl?submit=search&amp;types=COSII&amp;mapped=on">標記搜尋結果 (marker search results)</a>中找到。</p>

          <h4>COSII 基因完整列表 (Complete listing of COSII genes)</h4>

          <p>COSII 基因與標記的完整列表可在我們的<a href="/search/markers/markersearch.pl?submit=search&amp;types=COSII">標記搜尋結果</a>或此 <a href="/documents/markers/cosii.xls">.xls 試算表檔案</a>中找到。該試算表有時比搜尋結果更具時效性。序列文字檔及其他關聯的 COSII 數據可從我們的 <a href="ftp://ftp.sgn.cornell.edu/COSII/">FTP 站點 (FTP site)</a> 下載。</p>

          <ol>
            <li><span class="tinytype">Fulton T, van der Hoeven R,
            Eannetta N, Tanksley S (2002). Identification, Analysis
            and Utilization of a Conserved Ortholog Set (COS)
            Markers for Comparative Genomics in Higher Plants. The
            Plant Cell 14: 1457-1467</span></li>

            <li><span class="tinytype">Wu F, Mueller LA, Crouzillat D, Petiard V, Tanksley SD (2006).
Combining Bioinformatics and Phylogenetics to Identify Large Sets of
Single Copy, Orthologous Genes (COSII) for Comparative, Evolutinonary
and Systematics Studies: A Test Case in the Euasterid Plant Clade (2006).
Genetics, 2006 Nov;174(3):1407-20. <a href="http://www.genetics.org/cgi/content/abstract/genetics.106.062455v1">Genetics</a> | <a href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed&term=16951058">PubMed</a> | <a href="ftp://ftp.sgn.cornell.edu/COSII/COSII-Genetics-suppl/">[在 SGN FTP 站點存取補充資料]</a>
</span></li>
          </ol>
        </td>
      </tr>
    </table>
  </center>
END_HEREDOC
$page->footer();
