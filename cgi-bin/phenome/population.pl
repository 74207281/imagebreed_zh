use strict;
use warnings;
use utf8;

my $population_detail_page = CXGN::Phenome::PopulationDetailPage->new();

package CXGN::Phenome::PopulationDetailPage;


use CXGN::Page;
use CXGN::Page::FormattingHelpers qw /info_section_html
                                      page_title_html
                                      columnar_table_html
                                      html_optional_show
                                      info_table_html
                                      tooltipped_text
                                      html_alternate_show
                                      /;

use CXGN::Phenome::Population;
use CXGN::Phenome::PopulationDbxref;
use CXGN::People::PageComment;
use CXGN::People::Person;
use CXGN::Chado::Publication;
use CXGN::Chado::Pubauthor;
use CXGN::Contact;
use CXGN::Map;
use File::Temp qw / tempfile /;
use File::Path qw / mkpath  /;
use File::Copy;
use File::Spec;
use File::Basename;

use base qw / CXGN::Page::Form::SimpleFormPage CXGN::Phenome::Main/;

use CatalystX::GlobalContext qw( $c );


sub new {
    my $class = shift;
    my $self = $class->SUPER::new(@_);
    $self->set_script_name("population.pl");


    return $self;
}

sub define_object {
    my $self = shift;

    # call set_object_id, set_object and set_primary_key here
    # with the appropriate parameters.
    #
    $self->set_dbh( CXGN::DB::Connection->new );
    my %args = $self->get_args();
    my $population_id= $args{population_id};
    unless (!$population_id || $population_id =~m /^\d+$/) { $self->get_page->message_page("No population exists for identifier $population_id"); }
    $self->set_object_id($population_id);
    $self->set_object(CXGN::Phenome::Population->new($self->get_dbh(),$self->get_object_id()));
    $self->set_primary_key("population_id");
    $self->set_owners($self->get_object()->get_owners());
}




sub generate_form {
    my $self = shift;

    $self->init_form();

    my %args = $self->get_args();

    my $population = $self->get_object();
    my $population_id = $self->get_object_id();
    my $type_id = $args{type_id};
    my $type=$args{type};

    my ($submitter, $submitter_link) = $self->submitter();

    my $login_user= $self->get_user();
    my $login_user_id= $login_user->get_sp_person_id();
    my $form = undef;

    if ($self->get_action()=~/edit|store/ && ($login_user_id = $submitter || $self->get_user()->get_user_type() eq 'curator') ) {
        $form = CXGN::Page::Form::Editable->new();
    }
    else {
        $form = CXGN::Page::Form::Static->new();
    }

   $form->add_field(
                      display_name=>"名稱 (Name):",
                      field_name=>"name",
                      length=>15,
                      object=>$population,
                      getter=>"get_name",
                      setter=>"set_name",
                      validate => 'string',
                      );
    $form->add_textarea(
                          display_name=>"描述 (Description): ",
                          field_name=>"description",
                          object=>$population,
                          getter=>"get_description", setter=>"set_description",
                          columns => 40,
                          rows =>4,
                          );


    $form->add_label( display_name=>"上傳者 (Uploaded by): ",
                          field_name=>"submitter",
                          contents=>$submitter_link,
                          );
    $form->add_hidden( field_name=>"population_id", contents=>$args{population_id});

    $form->add_hidden (
                       field_name => "sp_person_id",
                       contents   =>$self->get_user()->get_sp_person_id(),
                       object     => $population,
                       setter     =>"set_sp_person_id",
                       );

    $form->add_hidden( field_name=>"action", contents=>"store"  );





    $self->set_form($form);

    if ($self->get_action=~ /view|edit/) {
        $self->get_form->from_database();


    }elsif ($self->get_action=~ /store/) {
        $self->get_form->from_request($self->get_args());

 }



}

sub display_page {
    my $self = shift;

    $self->get_page->add_style( text => <<EOS);

a.abstract_optional_show {
  color: blue;
  cursor: pointer;
  white-space: nowrap;
}
div.abstract_optional_show {
  background: #f0f0ff;
  border: 1px solid #9F9FC7;
  margin: 0.2em 1em 0.2em 1em;
  padding: 0.2em 0.5em 0.2em 1em;
}
EOS



    my %args = $self->get_args();

    my $population = $self->get_object();
    my $population_id = $self->get_object_id();
    my $population_name = $population->get_name();

    my $action = $args{action};
    if (!$population_id && $action ne 'new' && $action ne 'store')
                     { $self->get_page->message_page("No population exists for this identifier"); }
    ################################
    #redirecting to the stock page 
    my $stock_id = $population->get_stock_id;
    $c->throw(is_error=>1,
              message=>"No population exists for identifier $population_name (id = $population_id)",
        ) if !$stock_id;
    $self->get_page->client_redirect("/stock/$stock_id/view");
    ###############
    #used to show certain elements to only the proper users
    my $login_user= $self->get_user();
    my $login_user_id= $login_user->get_sp_person_id();
    my $login_user_type= $login_user->get_user_type();
    my $page="../phenome/population.pl?population_id=$population_id";

    $self->get_page()->header("SGN 族群名稱 (Population name): $population_name");

    print page_title_html("族群 (Population): $population_name \n");

    $args{calling_page} = $page;

    my $population_html = $self->get_edit_link_html(). "\t[<a href=/phenome/qtl_form.pl>新增 QTL 族群 (New QTL Population)</a>] <br />";

    #print all editable form  fields
    $population_html .= $self->get_form()->as_table_string();


    my ($phenotype, $is_qtl_pop);
    my @phenotype;
    my $graph_icon = qq |<img src="../documents/img/pop_graph.png"/> |;

    my $qtltool = CXGN::Phenome::Qtl::Tools->new();
    my @pops = $qtltool->has_qtl_data();

    foreach my $pops (@pops)
    {
        my $pops_id = $pops->get_population_id();
        if ($pops_id == $population_id)
        {
            $is_qtl_pop = 1;
        }
    }

    if ($population->get_web_uploaded()) {
        my @traits = $population->get_cvterms();

        foreach my $trait (@traits)  {
            my $trait_id = $trait->get_user_trait_id();
            my $trait_name = $trait->get_name();
            my $definition = $trait->get_definition();
            my ($min, $max, $avg, $std, $count)= $population->get_pop_data_summary($trait_id);

            my $cvterm_obj  = CXGN::Chado::Cvterm::get_cvterm_by_name( $self->get_dbh(), $trait_name);
            my $trait_link;
            my $cvterm_id = $cvterm_obj->get_cvterm_id();
            if ($cvterm_id)
            {
                $trait_link = qq |<a href="/cvterm/$cvterm_id/view">$trait_name</a>|;

            } else
            {
                $trait_link = qq |<a href="/phenome/trait.pl?trait_id=$trait_id">$trait_name</a>|;
            }

            if ($is_qtl_pop)
            {
                if ($definition)
                {
                    push  @phenotype,  [map {$_} ( (tooltipped_text($trait_link, $definition)),
                                    $min, $max, $avg,
                           qq | <a href="/phenome/population_indls.pl?population_id=$population_id&amp;cvterm_id=$trait_id">
                                 $count</a>
                              |,
                           qq | <a href="/phenome/population_indls.pl?population_id=$population_id&amp;cvterm_id=$trait_id">
                                  $graph_icon</a>
                              | )];
                } else
                {
                    push  @phenotype,  [map {$_} ($trait_name, $min, $max, $avg,
                          qq | <a href="/phenome/population_indls.pl?population_id=$population_id&amp;cvterm_id=$trait_id">
                             $count</a>
                             |,
                           qq | <a href="/phenome/population_indls.pl?population_id=$population_id&amp;cvterm_id=$trait_id">
                                  $graph_icon</a>
                              |  )];
                }
            } else
            {
                if ($definition)
                {
                    push  @phenotype,  [map {$_} ( (tooltipped_text( $trait_link, $definition )),
                                    $min, $max, $avg, $count )];
                } else
                { push  @phenotype,  [map {$_} ( $trait_name, $min, $max, $avg, $count )];
                }
            }
        }
    }
     else {
         my @cvterms = $population->get_cvterms();
         foreach my $cvterm(@cvterms)
         {
             my ($min, $max, $avg, $std, $count)= $population->get_pop_data_summary($cvterm->get_cvterm_id());
             my $cvterm_id = $cvterm->get_cvterm_id();
             my $cvterm_name = $cvterm->get_cvterm_name();

             if ($is_qtl_pop)
             {
                 if ($cvterm->get_definition())
                 {
                     push  @phenotype,  [map {$_} ( (tooltipped_text( qq|<a href="/cvterm/$cvterm_id/view">
                                                                      $cvterm_name</a>
                                                                     |,
                                    $cvterm->get_definition())), $min, $max, $avg, $count,
                          qq | <a href="/phenome/population_indls.pl?population_id=$population_id&amp;cvterm_id=$cvterm_id">
                               $graph_icon</a>
                             | ) ];
                 } else
                 { push  @phenotype,  [map {$_} (qq | <a href="/cvterm/$cvterm_id/view">$cvterm_name</a>|,
                            $min, $max, $avg, $count,
                      qq | <a href="/phenome/population_indls.pl?population_id=$population_id&amp;cvterm_id=$cvterm_id">
                           $graph_icon</a>
                        |  ) ];
                 }
             } else
             {
                 if ($cvterm->get_definition())
                 {
                     push  @phenotype,  [map {$_} ( (tooltipped_text( qq|<a href="/cvterm/$cvterm_id/view">
                                                                      $cvterm_name</a>
                                                                     |,
                                    $cvterm->get_definition())), $min, $max, $avg, $count) ];
                 } else
                 {
                     push  @phenotype,  [map {$_} (qq | <a href="/cvterm/$cvterm_id/view">$cvterm_name</a>|,
                            $min, $max, $avg, $count ) ];
                 }
             }
         }
     }

    my $accessions_link = qq |<a href="../search/phenotype_search.pl?wee9_population_id=$population_id">
                              檢視所有種原 (See all accessions)...</a>
                             |;

    my ($phenotype_data, $data_view, $data_download);

    if (@phenotype)
    {
        if ($is_qtl_pop) {
            $phenotype_data = columnar_table_html(headings => [
                                                           '性狀 (Trait)',
                                                           '最小值 (Minimum)',
                                                           '最大值 (Maximum)',
                                                           '平均值 (Average)',
                                                           '品系數量 (No. of lines)',
                                                           'QTL...',
                                                           ],
                                              data     =>\@phenotype,
                                              __alt_freq   =>2,
                                              __alt_width  =>1,
                                              __alt_offset =>3,
                                              __align =>'l',
                                              );

            $data_download .=  qq { <span><br/><br/>下載 (Download): <a href="phenotype_download.pl?population_id=$population_id"><b>\
                                [表型原始資料 (Phenotype raw data)]</b></a> <a href="genotype_download.pl?population_id=$population_id"><b>\
                                [基因型原始資料 (Genotype raw data)]</b></a></span>
                              };


        } else
        {
            $phenotype_data = columnar_table_html(headings => [
                                                           '性狀 (Trait)',
                                                           '最小值 (Minimum)',
                                                           '最大值 (Maximum)',
                                                           '平均值 (Average)',
                                                           '品系數量 (No. of lines)',
                                                           ],
                                              data     =>\@phenotype,
                                              __alt_freq   =>2,
                                              __alt_width  =>1,
                                              __alt_offset =>3,
                                              __align =>'l',
                                              );

            $data_download .=  qq { <span><br/><br/>下載 (Download): <a href="phenotype_download.pl?population_id=$population_id"><b>\
                                [表型原始資料 (Phenotype raw data)]</b></a></span>
                              };

        }



    }


    my $pub_subtitle;
    if ($population_name && ($login_user_type eq 'curator' || $login_user_type eq 'submitter')) {
        $pub_subtitle .= qq|<a href="../chado/add_publication.pl?type=population&amp;type_id=$population_id&amp;refering_page=$page&amp;action=new">[關聯文獻 (Associate publication)]</a>|;

    }

    else { $pub_subtitle= qq|<span class=\"ghosted\">[關聯文獻 (Associate publication)]</span>|;

    }


    my $pubmed;
    my $url_pubmed = qq | http://www.ncbi.nlm.nih.gov/pubmed/|;

    my @publications = $population->get_population_publications();
    my $abstract_view;
    my $abstract_count = 0;



    foreach my $pub (@publications) {
        my ($title, $abstract, $authors, $journal, $pyear,
            $volume, $issue, $pages, $obsolete, $pub_id, $accession
           );
        $abstract_count++;

        my @dbxref_objs = $pub->get_dbxrefs();
        my $dbxref_obj = shift(@dbxref_objs);

        $obsolete = $population->get_population_dbxref($dbxref_obj)->get_obsolete();

        if ($obsolete eq 'f') {
            $pub_id = $pub->get_pub_id();
            $title = $pub->get_title();
            $abstract = $pub->get_abstract();
            $pyear = $pub->get_pyear();
            $volume = $pub->get_volume();
            $journal = $pub->get_series_name();
            $pages = $pub->get_pages();
            $issue = $pub->get_issue();

            $accession = $dbxref_obj->get_accession();
            my $pub_info = qq|<a href="/publication/$pub_id/view" >PMID:$accession</a>|;

            my @authors;
            my $authors;
            if ($pub_id) {

                my @pubauthors_ids = $pub->get_pubauthors_ids($pub_id);

                foreach my $pubauthor_id (@pubauthors_ids) {
                    my  $pubauthor_obj = CXGN::Chado::Pubauthor->new($self->get_dbh, $pubauthor_id);
                    my $last_name  = $pubauthor_obj->get_surname();
                    my $first_names = $pubauthor_obj->get_givennames();
                    my @first_names = split (/,/, $first_names);
                    $first_names = shift (@first_names);
                    push @authors, ("$first_names" ."  ". "$last_name");
                    $authors = join (", ", @authors);
                }
            }




            $abstract_view = html_optional_show("abstracts$abstract_count",
                               '顯示/隱藏摘要 (Show/hide abstract)',
                               qq|$abstract <b> <i>$authors.</i> $journal. $pyear. $volume($issue). $pages.</b>|,
                                                 0, #< do not show by default
                                                 'abstract_optional_show', #< don't use the default button-like style
                                                );


            $pubmed .= qq| <div><a href="$url_pubmed$accession" target="blank">$pub_info</a> $title $abstract_view</div> |;
        }
    }

    print info_section_html(title   => '族群詳細資訊 (Population Details)',
                            contents => $population_html,
                            );

    my $is_public = $population->get_privacy_status();
    if ( $is_public
         || $login_user_type eq 'curator'
         || $login_user_id == $population->get_sp_person_id()
       )
    {
        if (-s $population->phenotype_file($c))
        {
            my $correlation_data = $self->display_correlation();

            print info_section_html(title    => '表型資料與 QTL (Phenotype Data and QTLs)',
                                    contents => $phenotype_data ." ".$data_download
                                   );

            print info_section_html( title    => '皮爾森相關性分析 (Pearson Correlation Analysis)',
                                     contents => $correlation_data,
                                   );
        }
        else
        {
            print info_section_html(title    => '表型資料 (Phenotype Data)',
                                    contents => $accessions_link
                                   );
        }

        my $map_link = $self->genetic_map();
        unless (!$map_link)
        {
            print info_section_html( title    => '遺傳圖譜 (Genetic Map)',
                                     contents => $map_link
                                   );
        }

    }
    else
    {
        my ($submitter_obj, $submitter_link) = $self->submitter();
        my $message = "此族群的 QTL 資料尚未公開 (The QTL data for this population is not public yet)。
                       如果您想了解有關此資料的更多資訊，請聯絡資料擁有者 (please contact the owner of the data): <b>$submitter_link</b>
                       或發送電子郵件至 SGN (or email to SGN):
                       <a href=mailto:sgn-feedback\@sgn.cornell.edu>
                       sgn-feedback\@sgn.cornell.edu</a>。\n";

        print info_section_html(title   => '表型資料與 QTL (Phenotype Data and QTLs)',
                                contents =>$message,
                               );

    }

    print info_section_html(title   => '文獻註釋 (Literature Annotation)',
                            #subtitle => $pub_subtitle,
                            contents => $pubmed,
                            );



###################

    if ($population_name) {
        # change sgn_people.forum_topic.page_type and the CHECK constraint!!
        my $page_comment_obj = CXGN::People::PageComment->new($self->get_dbh(), "population", $population_id, $self->get_page()->{request}->uri()."?".$self->get_page()->{request}->args());
        print $page_comment_obj->get_html();
    }

    $self->get_page()->footer();


    exit();
}






# override store to check if a locus with the submitted symbol/name already exists in the database

sub store {
   my $self = shift;
   my $population = $self->get_object();
   my $population_id = $self->get_object_id();
   my %args = $self->get_args();

   $self->SUPER::store(0);

 exit();
}


sub submitter {
    my $self = shift;
    my $population = $self->get_object();
    my $sp_person_id= $population->get_sp_person_id();
    my $submitter = CXGN::People::Person->new($self->get_dbh(), $population->get_sp_person_id());
    my $submitter_name = $submitter->get_first_name()." ".$submitter->get_last_name();
    my $submitter_link = qq |<a href="/solpeople/personal-info.pl?sp_person_id=$sp_person_id">$submitter_name</a> |;

    return $submitter, $submitter_link;

}

sub genetic_map {
    my $self     = shift;
    my $mapv_id  = $self->get_object()->mapversion_id();

    if ($mapv_id) {
        my $map      = CXGN::Map->new( $self->get_dbh(), { map_version_id => $mapv_id } );
        my $map_name = $map->get_long_name();
        my $map_sh_name = $map->get_short_name();
        my $genetic_map =
            qq | <a href=/cview/map.pl?map_version_id=$mapv_id>$map_name ($map_sh_name)</a>|;

        return $genetic_map;
    }
    else {
        return;
    }

}

=head2 analyze_correlation

 Usage: my ($heatmap_file, $corre_table_file) = $self->analyze_correlation();
 Desc: runs correlation analysis (R) in the cluster system
       for all the traits assayed for a population
       and returns a heatmap of the correlation coeffients
       (documents/tempfiles/correlation/heatmap_file.png)
       and a table containing the correlation coeffients
       and their p-values ( /data/prod/tmp/r_qtl/corre_table_file.txt).
 Ret: heatmap image file  and correlation output text file
 Args: None
 Side Effects:
 Example:

=cut

sub analyze_correlation
{
    my $self   = shift;
    my $pop    = $self->get_object();
    my $pop_id = $self->get_object_id();

    my $pheno_file      = $pop->phenotype_file($c);
    my $pheno_dir       = $c->config->{solqtl};
    my $temp_image_dir  = File::Spec->catfile($pheno_dir, "temp_images");
    my $corre_image_dir = File::Spec->catfile($temp_image_dir, "correlation");
    my $corre_temp_dir  = File::Spec->catfile($pheno_dir, "tempfiles");
    my $pheno_file_dir  = File::Spec->catfile($pheno_dir, "cache");
   
    if (-s $pheno_file) {
        foreach my $dir ($corre_image_dir, $corre_temp_dir, $pheno_file_dir)
        {
            unless (-d $dir)
            {
                mkpath ($dir, 0, 0755);
            }
        }

        my (undef, $heatmap_file)     = tempfile( "heatmap_${pop_id}-XXXXXX",
                                              DIR      => $corre_temp_dir,
                                              SUFFIX   =>'.png',
                                              UNLINK   => 1,
                                            );

        my (undef, $corre_table_file) = tempfile( "corre_table_${pop_id}-XXXXXX",
                                              DIR      => $corre_temp_dir,
                                              SUFFIX   => '.txt',
                                              UNLINK   => 1,
                                            );

        my ( $corre_commands_temp, $corre_output_temp ) =
            map
        {
            my ( undef, $filename ) =
                tempfile(
                    File::Spec->catfile(
                        CXGN::Tools::Run->temp_base($corre_temp_dir),
                        "corre_pop_${pop_id}-$_-XXXXXX"
                    ),
                    UNLINK =>0,
                );
            $filename
        } qw / in out /;

        {
            my $corre_commands_file = $c->path_to('/cgi-bin/phenome/correlation.r');
            copy( $corre_commands_file, $corre_commands_temp )
                or die "could not copy '$corre_commands_file' to '$corre_commands_temp'";
        }

        my $r_process = CXGN::Tools::Run->run_cluster(
            'R', 'CMD', 'BATCH',
            '--slave',
            "--args $heatmap_file $corre_table_file $pheno_file",
            $corre_commands_temp,
            $corre_output_temp,
            {
                working_dir => $corre_temp_dir,
                max_cluster_jobs => 1_000_000_000,
            },
            );

        sleep 1 while $r_process->alive;

        copy( $heatmap_file, $corre_image_dir )
            or die "could not copy $heatmap_file to $corre_image_dir";

        $heatmap_file = fileparse($heatmap_file);
        $heatmap_file  = $c->generated_file_uri("correlation",  $heatmap_file);

        return $heatmap_file, $corre_table_file;
    }
    else {
        return undef;
    }

}



=head2 display_correlation

 Usage: my $corre_data = $self->display_correlation();
 Desc: used to display the output of the correlation analysis,
       including the heatmap, links for downloading the
       correlation coefficients and their p-values and
       a key table for the acronyms of the traits used
       in the correlation plot
 Ret: a scalar variable with what needs to be shown in the
      correlation section of the page
 Args: None
 Side Effects:
 Example:

=cut

sub display_correlation {
    my $self = shift;
    my $pop  = $self->get_object();
    my $pop_id = $self->get_object_id();
    my $corre_data;

    #there seems to be a problem with the phenotype data of one population (pop id = 18), 
    #causing problem to the R correlation analysis and thus crashing the pop page.
    #unitl I identify the problem, displaying the message below  in case the site is updated
    #before I identify the problem.
   
    if ($pop_id == 18) 
    { 
	$corre_data = qq | 無法對此族群執行相關性分析 (Correlation analysis cannot be run for this population)。 |;
    }
    else 
    {
	my ($heatmap_file, $corre_table_file) = $self->analyze_correlation();

	my $heatmap_image = qq |<img alt="correlation heatmap image" src="$heatmap_file"/> |;

	my @traits = $pop->get_cvterms();
	my @tr_acronym_table;
	my $name;
	foreach my $tr (@traits)
	{
	    if ( $pop->get_web_uploaded )
	    {
		$name = $tr->get_name();
	    } 
	    else
	    {
            $name = $tr->get_cvterm_name();
	    }
	    my $tr_acronym= $pop->cvterm_acronym($name);
	    push @tr_acronym_table, [ map { $_ } ( $tr_acronym, $name) ];
	}

	my $acronym_key  = columnar_table_html(
                                           headings     => [ '縮寫 (Acronym)',  '性狀 (Trait)'],
                                           data         => \@tr_acronym_table,
                                           __alt_freq   => 2,
                                           __alt_width  => 1,
                                           __alt_offset => 3,
                                           __align      => 'l',
                                          );

	my  $acronym_view = html_optional_show("key",
                                           '顯示/隱藏縮寫對照 (Show/hide acronym key)',
                                           qq | $acronym_key |,
                                           0,
                                          );

	$corre_data = $heatmap_image .  qq | <span><br/><br/>下載 (Download): <a href="correlation_download.pl?population_id=$pop_id&amp;corre_file=$corre_table_file">[相關係數與 p 值表格 (Correlation coefficients and p-values table)]</a> $acronym_view</span> |;
    }
    return $corre_data;

}
