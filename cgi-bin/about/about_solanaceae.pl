use strict;
use warnings;
use utf8;
use CXGN::Page;
my $page=CXGN::Page->new('about_solanaceae.html','html2pl converter');
$page->header('關於茄科植物(About The Solanaceae family)');
print<<END_HEREDOC;

  <center>


    <table summary="" width="720" cellpadding="0" cellspacing="0"
    border="0">
      <tr>
        <td>
          <center>
            <h2>關於茄科家族(About the Solanaceae Family)</h2>
          </center>
        </td>
      </tr>

      <tr>
        <td>
          <center>
            <img src="/documents/img/solanaceae-image-small.jpg" border="0"
            alt="types of solanaceae" />
          </center>

<p>茄科（Solanaceae，亦稱夜茄科）包含 3000 多個物種，其中許多物種是在南美洲安地斯/亞馬遜地區劇烈變化的棲地中演化而來，包括年降雨量超過 3 公尺的雨林，到幾乎沒有降雨的沙漠，以及有規律降雪與零下低溫的高山。(The Solanaceae, also called nightshades, comprise more than 3000 species many of which evolved in the Andean/Amazonian regions of South America in habitats that vary dramatically and include rain forests that receive more than 3 meters of rainfall annually to deserts with virtually no rainfall and high mountains with regular snowfall and subfreezing temperatures.)</p>

          <p>茄科的多樣性中心靠近赤道，因此物種未受冰河時期的干擾，有時間為極端生態位累積適應性遺傳變異。茄科在經濟上也是第三重要的植物分類群，在蔬菜作物方面最有價值，在農業實用性方面也是作物物種中最多樣化的，包括結薯的馬鈴薯、多種結果蔬菜（番茄、茄子、辣椒）、觀賞植物（矮牽牛、菸草）、具食用葉片的植物（Solanum aethiopicum、S. macrocarpon）和藥用植物（如曼陀羅、辣椒）。(The center of diversity of the Solanaceae is near the equator and thus species were undisturbed by the ice ages and have had time to accumulate adaptive genetic variation for extreme ecological niches.)</p>

          <p>茄科作物經歷了人類密集選育，使其成為研究植物與人類之間演化界面的模式。茄科古老的演化模式，加上在巨觀和微觀層面上極高程度的基因組組織保守性，使該科成為探索表型多樣性基礎以及對自然與農業環境適應性的模式。(Solanaceaous crops have been subjected to intensive human selection, allowing their use as models to study the evolutionary interface between plants and people.)</p>

          <p>一些茄科植物是重要的生物學模式系統；其中包括用於果實成熟和植物防禦的番茄、用於植物防禦的菸草，以及用於花青素色素生物學的矮牽牛。(Some Solanaceae plants are important model systems for biology; these include tomato for fruit ripening and plant defense, tobacco for plant defense, and petunia for the biology of anthocyanin pigments.)</p>

          <p>最近，茄科的親緣關係分類已進行了<a href="solanum_nomenclature.pl">修訂(revised)</a>。番茄屬 (Lycopersicon) 被重新併入茄屬 (Solanum)，正如林奈分類法中的情況一樣。(Recently, the phylogenetic classification of the Solanaceae has been revised. The genus Lycopersicon was re-integrated into the Solanum genus, as had been the case in Linnaeus' classification.)</p>

          <h4>茄科親緣關係樹(Solanaceae phylogenetic tree)</h4>

<p>以下為茄科（含咖啡）親緣關係總覽，由吳斐南 (Feinan Wu) 依據 Bohs 與 Olmstead (1997) 友情提供。(Below is an overview of the phylogeny of the Solanaceae (incl. coffee), kindly provided by Feinan Wu, based on Bohs and Olmstead, (1997).)</p>

          <center>
            <img src="/documents/img/SOL_tree.png" alt=
            "phylogeny of the Solanaceae" />
          </center>

          <h4>更多文件(Further documents)</h4>

          <ul>
            <li><a href="solanum_nomenclature.pl">茄屬命名法變更總覽(An overview of changes in the Solanum nomenclature)</a>。由英國倫敦自然歷史博物館 Sandra Knapp 教授友情提供。</li>
            <li>其他茄科資源的連結可在我們的<a href="/community/links/related_sites.pl">茄科相關連結(Solanaceae links)</a>頁面中找到。</li>
	    <li>番茄與馬鈴薯之<a href="/misc/codon_usage/codon_usage.pl">密碼子使用偏好性(codon usage)</a>分析，含密碼子使用表。</li>
          </ul>

          <h4>參考文獻(References)</h4>

<p>Bohs L., Olmstead R. G. (1997)
          Phylogenetic relationships in Solanum (Solanaceae) based
          on ndhF sequences. Syst. Bot. 22: 5-17.</p>


          </td>
      </tr>
    </table>
  </center>
END_HEREDOC
$page->footer();
