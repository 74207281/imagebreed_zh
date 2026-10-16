use strict;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('unigene-builds.html','html2pl converter');
$page->header('SGN 單一基因構建 (SGN Unigene Builds)');
print<<END_HEREDOC;

  <center>

    <table summary="" width="720" cellpadding="0" cellspacing="0"
    border="0">
      <tr>
        <td>
          

          <h3>SGN 單一基因構建 (SGN Unigene Builds)</h3>

          <p>Sol Genomics Network 單一基因構建代表茄科物種表現基因的「最小冗餘」集合，由 SGN 資料庫中的 EST/cDNA 序列資料構建而成。單一基因集是透過將表面上屬於同一基因片段的 EST 序列（在考慮定序錯誤和等位基因變異後）組裝在一起成為重疊群 (contig) 來「構建」的。在包含多個物種 EST 的構建版本中，允許較大的變異以因應直系同源基因的預期演化分歧。(The Sol Genomics Network unigene builds represent "minimally redundant" collections of expressed genes in Solanaceous species, constructed from EST/cDNA sequence data present in SGN's databases.)</p>

          <p>SGN 的單一基因組裝策略，以及序列恢復與修剪，正處於積極研究中並持續進行改良。當組裝流程取得進展或有新的輸入資料可用時，將會發布新的構建版本。(SGN's unigene assembly strategy, as well as sequence recovery and trimming, is under active research and continually refined.)</p>

          <p>最新構建版本公布於下方。有關<a href="unigene-methods.pl">方法 (methods)</a>的更多資訊，請點擊感興趣的構建版本旁的下方連結。另請參閱我們關於 SGN 組裝流程的<a href="unigene-validation.pl">驗證 (validation)</a>說明以及與 <a href="http://www.tigr.org/tdb/tgi/">TIGR 番茄基因索引 (TIGR's tomato gene index)</a>的比較。(The latest builds are posted below. For more information on methods, click the links below...)</p>
        </td>
      </tr>
      
    </table>
  </center>
END_HEREDOC
$page->footer();