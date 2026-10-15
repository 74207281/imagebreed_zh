#!/usr/bin/perl
# Signal peptide finder using a genentech-script-generated HMMER model
# modified by Evan 9 / 16 / 05
#
# arguments: sequences (string), filename (string), display_opt(filter/color),
#   use_eval_cutoff(bool), use_bval_cutoff(bool), eval_cutoff(real), bval_cutoff(real)

use strict;
use warnings;
use utf8;

use CXGN::Page;
use Bio::SearchIO;
use Bio::SeqIO;
use IO::String;

my $ss_find_obj = SigpepFind->new();
$ss_find_obj->process_seqs();

exit;

################################################################################
package SigpepFind;
use strict;
use CatalystX::GlobalContext '$c';
use warnings;
use utf8;
use English;

sub new {
    my $classname  = shift;
    my $obj        = {};      #a reference to an anonymous hash

    #all fields are listed here
    $obj->{debug}         = 0;     #0 or 1
    $obj->{sequences}     = "";    #string with raw input from textbox
    $obj->{file_contents} = "";    #string with raw input from file
    $obj->{illegal_input_count} =
      0;    #number of illegally formatted sequences found
    $obj->{seqarray} =
      [];    #arrayref of records like {seq => input sequence, id => descriptor}
    $obj->{error}  = 0;     #set to 1 in check_input() if necessary
    $obj->{output} = "";    #raw HMMER output
    $obj->{tmpdir} =$c->path_to( $c->tempfiles_subdir( 'sigpep_finder' ) );
    $obj->{hmmsearch_path} = $c->config->{'hmmsearch_location'};
    $obj->{page} = CXGN::Page->new( "訊號胜肽預測工具 (Signal Peptide Finder)", "Evan" );
    $obj->{content} = "";    #the output HTML

    bless( $obj, $classname );   #use $obj as an object of this type from now on
    $obj->get_params();          #retrieve parameters
    return $obj;                 #so it can be used like "$obj->func()"
}

#read parameters to script from the page object
#and read input from textbox and file into $self->{sequences} and $self->{file_contents}, respectively
sub get_params {
    my $self = shift(@_);
    ( $self->{sequences} ) =
      $self->{page}->get_arguments('sequences')
      ;    #retrieve the seqlist in string form from the in-page textbox
    ( $self->{display_opt} ) =
      $self->{page}->get_arguments('display_opt')
      ;    #whether to filter sequences in output or to show them in green/red
    ( $self->{truncate} ) = $self->{page}->get_arguments('truncate_seqs');
    if ( $self->{truncate} ) {
        ( $self->{truncate_type} ) =
          $self->{page}->get_arguments('truncate_type');
    }

#get an upload object to upload a file -- this and filling in the textbox are not mutually exclusive;
#each can hold either a list of fasta sequences or a single plaintext sequence
    my $upload = $self->{page}->get_upload();

    #check whether there's a filename in the filename text field
    if ( defined $upload ) {
        my $fh        = $upload->fh();
        my @fileLines = <$fh>
          ; #need this line to put the file into an array context; can't go straight to the join()
        $self->{file_contents} = join( '', @fileLines );
    }
    else {
        $self->{file_contents} = '';
    }

    #check input format and fill $self->{seqarray}
    $self->check_input();

    #output options
    ( $self->{use_eval_cutoff} ) =
      $self->{page}->get_arguments('use_eval_cutoff');
    if ( defined $self->{use_eval_cutoff} ) {
        ( $self->{eval_cutoff} ) = $self->{page}->get_arguments("eval_cutoff");
    }

    ( $self->{use_bval_cutoff} ) =
      $self->{page}->get_arguments('use_bval_cutoff');
    if ( defined $self->{use_bval_cutoff} ) {
        ( $self->{bval_cutoff} ) = $self->{page}->get_arguments("bval_cutoff");
    }
}

#make sure contents of input fields are legal, and put them in a useful array form in {seqarray}
#no parameters; return 0 or 1
sub check_input {
    my $self = shift(@_);

    #process input from textbox and fill seqarray
    my $error_msg =
      $self->read_sequences( $self->{sequences}, '序列輸入框 (sequence input box)' )
      ;    #includes the period at the end of a sentence
    if ( $error_msg ne '' ) {
        $self->print_warning("$error_msg 跳過剩餘的輸入內容。(Skipping the rest of the input.)");
    }

    #process input from uploaded file and fill seqarray
    $error_msg =
      $self->read_sequences( $self->{file_contents}, '上傳檔案 (uploaded file)' );
    if ( $error_msg ne '' ) {
        $self->print_warning("$error_msg 跳過剩餘的輸入內容。(Skipping the rest of the input.)");
    }

    #print extracted sequence info
    $self->debug( "seqarray: " . $self->{seqarray} );
    $self->debug( "length of seqarray: " . scalar( @{ $self->{seqarray} } ) );
    $self->debug(
        "uploaded ids:\n"
          . join( ",\n",
            map( $_->{'id'} . ": " . $_->{'seq'}, @{ $self->{seqarray} } ) )
          . "\n"
    );
}

#add given data, which has not been checked for legality or format, to $self->{seqarray},
#which is an arrayref with contents being hashrefs with {id}, {seq} fields
#two parameters: a stringref containing the data to be added,
#a one-word description of where the input is coming from (for debugging)
#return a string that's empty if no error
sub read_sequences {
    my ( $self, $data, $input_loc ) = @_;

    return '' unless $data =~ /\S/;    #< skip if no input seqs

    open my $in_fh, "<", \$data
      or die "could not open dataref";
    my $inio = Bio::SeqIO->new(
        "-fh"     => $in_fh,
        "-format" => $self->guess_input_format( \$data )
    );
    $inio->alphabet("protein");
    $inio->verbose(2);    #< make sure SeqIO will throw an exception
                          #whenever appropriate

    my $seq_count  = 0;
    my $valid_seqs = 0;
    eval {
        while ( my $seq = $inio->next_seq )
        {
            $seq_count++;
            my $temp_seq = uc $seq->seq();
            if ( my $illegals = $self->contains_illegal_alphabet($temp_seq) ) {
                $self->print_warning( "於 $input_loc 中第 $seq_count 條序列 ("
                      . ( $seq->id || '無名稱 (no name)' )
                      . ") 包含不合法字元 '$illegals'，已跳過。(contains illegal character(s) '$illegals', skipping.)"
                );
                next;
            }

            #add a record
            push(
                @{ $self->{seqarray} },
                {
                    'id' => defined( $seq->id() ) ? $seq->id() : 'UnknownSeq',
                    'seq' => $temp_seq
                }
            );
            $valid_seqs++;
        }
    };
    if ($EVAL_ERROR) {
        $self->print_error("序列處理失敗，請檢查輸入內容。(Sequence processing failed, please check input.)");
    }

    unless ( $valid_seqs > 0 ) {
        $self->print_error("序列處理失敗，無有效序列。(Sequence processing failed, no valid sequences.)");
    }
    return '';
}

#return our best guess as to what format the given input string is in,
#choosing from the following format strings accepted by Bioperl's SeqIO:
#raw fasta
sub guess_input_format {
    my $self    = shift(@_);
    my $dataref = shift(@_);
    if ( $$dataref =~ m/^\s*>/ ) {
        return "fasta";
    }
    else {

        #first remove all whitespace so we interpret it as a single sequence
        $$dataref =~ s/\s*//g;
        return "raw";
    }
}

#return whether the given string contains any illegal alphabet characters
#one parameter: a string that should be just a sequence, with nothing but [A-Z] in it,
#and maybe a * to mark the end of the sequence
#(also requires that the actual sequence have length at least one)
sub contains_illegal_alphabet {
    my ( $self, $data ) = @_;
    if ( $data =~ m/([bxz])/i ) {
        return $1;
    }
    return 0;
}

#process {seqarray} field; search with existing HMM
#no parameters
sub process_seqs {
    my $self = shift;

    # if we have an error, don't run the rest of it
    if ( $self->{error} ) {
        $self->write_page();
        return;
    }

#sequences are now in array form in {seqarray}
#hmmsearch input against may10_combined_lenSPEX.hmm (from 5 / 10 / 04; the best of the various hmms I created)

    #output to temp file
    my $outfilename = "$self->{tmpdir}/tmp.in.$$";    #$$ is this process' id
    open( OUTPUT, ">$outfilename" )
      or die "can't open '$outfilename' for writing: $!";
    foreach my $s ( @{ $self->{seqarray} } ) {
        print OUTPUT ( ">", $s->{'id'}, "\n", $s->{'seq'}, "\n" )
          or die "can't output indata to tempfile";
    }
    close(OUTPUT);

    #call hmmsearch
    my $infilename = "$self->{tmpdir}/tmp.out.$$";
    my $options    = "-A0";
    if ( $self->{display_opt} eq "filter" ) {
        if ( $self->{use_eval_cutoff} ) {
            $options .= " -E" . $self->{eval_cutoff};
        }
        if ( $self->{use_bval_cutoff} ) {
            $options .= " -T" . $self->{bval_cutoff};
        }
    }
    ################### make sure the call to hmmer is up to date ###################
    my $hmmfile =
      $self->{page}->path_to(
        'cgi-bin/tools/sigpep_finder/hmmlib/may10_combined_lenSPEX.hmm');
    -f $hmmfile or die "could not find hmmfile '$hmmfile'";
    system
      "$self->{hmmsearch_path} $options $hmmfile $outfilename > $infilename";
    die "$! running hmmsearch executable '$self->{hmmsearch_path}'"
      if $CHILD_ERROR;

    #input from temp output file by means of a Bio::SearchIO
    my $resultString = '';

    my $inio = Bio::SearchIO->new( -format => 'hmmer', -file => $infilename );
    while ( my $result = $inio->next_result() ) {

        #there should only be one "result", since we only use one hmm library

        #result is a Bio::Search::Result::HMMERResult object
        my $qname = $result->query_name();
        $resultString .= <<EOHTML;
				<h2 style="text-align: center">HMM $qname 分析結果 (Results for HMM $qname)</h2>
				<p>若您選擇「顯示所有輸出」，請注意顯示內容受限於 HMMER 所產生的輸出；它並不一定會回報所有輸入序列的結果。標記為「可能性最低 (Least likely)」具有訊號胜肽的序列，僅代表在<i>有回報結果的序列中</i>可能性最低；未出現在結果表格中的序列，具有訊號胜肽的可能性更低。</p>
				<p>有關輸出的詳細說明，請參閱 <a href="/documents/hmmer_userguide.pdf">HMMER 使用者手冊 (pdf)</a> 中的「search the sequence database with hmmsearch」章節。</p>
				<table style="margin: 0 auto" border="0" cellspacing="0" cellpadding="1">
					<tr>
						<td align="center" bgcolor="#e0ddff"><b>&nbsp;&nbsp;&nbsp;序列 (Sequence)&nbsp;&nbsp;|&nbsp;&nbsp;區域 (Domain)&nbsp;&nbsp;&nbsp;</b>
						<td align="center" bgcolor="#d0ccee"><b>&nbsp;&nbsp;&nbsp;分數 (Score)&nbsp;&nbsp;|&nbsp;&nbsp;E-值 (E-value)&nbsp;&nbsp;&nbsp;</b>
						<td align="center" bgcolor="#e0ddff"><b>&nbsp;&nbsp;&nbsp;訊號胜肽可能性 (Signal Likelihood)&nbsp;&nbsp;&nbsp;</b>
 					</tr>
EOHTML
        my $lineNum = 0;
        my ( $hit, $hsp, $color, $colStr1, $colStr2 );
        my $next_hit = $result->next_hit();
        if ( !$next_hit ) {
            $resultString .=
              qq|</table>\n<div style="margin: 1em auto; text-align: center; width: 20%; color: #ff0000">[ 無匹配結果 (no hits) ]</div>\n|;
        }
        else {
            while ( $hit = $next_hit ) {
                $hsp      = $hit->next_hsp();
                $next_hit = $result->next_hit();
                if ( $self->{display_opt} eq "color" ) {
                    if (
                        $hit->raw_score() > (
                            defined( $self->{bval_cutoff} )
                            ? $self->{bval_cutoff}
                            : -1e6
                        )
                        && $hsp->evalue() < (
                            defined( $self->{eval_cutoff} )
                            ? $self->{eval_cutoff}
                            : 1e12
                        )
                      )
                    {
                        $color = "#559955";
                    }
                    else {
                        $color = "#994444";
                    }
                    $colStr1 = "<font color=\"$color\"><b>";
                    $colStr2 = "</b></font>";
                }
                else {
                    $colStr1 = "";
                    $colStr2 = "";
                }
                $resultString .= "
                                                        <tr>
                                                                <td align=\"left\" bgcolor=\"#e0ddff\">"
                  . $colStr1
                  . $hit->name()
                  . $colStr2
                  . "<td align=\"left\" bgcolor=\"#d0ccee\">&nbsp;"
                  . $colStr1
                  . $hit->raw_score()
                  . $colStr2
                  . "<td align=\"center\" bgcolor=\"#e0ddff\">"
                  . $colStr1
                  . (
                      ( $lineNum == 0 )
                    ? ( $next_hit ? "可能性最高 (Most likely)" : "n/a" )
                    : ( !$next_hit ? "可能性最低 (Least likely)" : "&#8595;" )
                  )
                  . $colStr2 . "</tr>
                                                        <tr>
                                                                <td align=\"right\" bgcolor=\"#e0ddff\">1&nbsp;"
                  . "<td align=\"right\" bgcolor=\"#d0ccee\">"
                  . $hsp->evalue()
                  . "<td align=\"center\" bgcolor=\"#e0ddff\">" . "</tr>";
                $lineNum++;
            }
            $resultString .= "</table>\n";
        }
        $resultString .= <<EOHTML;
                                        <table border="0" cellspacing="10" cellpadding="0">
                                                <tr>
                                                        <td colspan="1" align="center"><b>HMMER 直方圖 (HMMER histogram)</b>
                                                </tr>
                                                <tr>
                                                        <td colspan="1" align="left">
                                                                &nbsp;&nbsp;&nbsp;直方圖比較了觀察到的 (obs) 序列分數分佈與由相同大小但填滿隨機序列的檔案所預期的 (exp) 分佈。等號 (=) 的分佈相對於星號 (*) 在頁面中越偏向下方，您的序列包含訊號胜肽的可能性就越高。如果您提交的序列都來自同一個蛋白質家族，此直方圖可暗示該家族是否可能具備分泌性質。
                                                </tr>
                                                <tr>
                                                        <td align="left">
                                                                <pre><code>
EOHTML

        #reopen file to read and print histogram
        open( INPUT, "<$infilename" );
        my $line;
        while ( $line = <INPUT> ) {
            if ( $line =~
                m/istogram/ )    #line ought to read "Histogram of all scores:"
            {
                while ( ( $line = <INPUT> ) !~ m/^\s*$/ ) {
                    $resultString .= $line;
                }
            }
        }
        close(INPUT);

        $resultString .= <<EOH;
                                                                </code></pre>
                                                </tr>
                                        </table>
EOH

    }

    $self->print($resultString);

    #remove temp files
    #	`rm $outfilename $infilename`;

    $self->write_page();
}

#print to the content field
#one parameter: string to be displayed
sub print {
    my $self = shift(@_);
    $self->{content} .= shift(@_);
}

#print to the content field, depending on the debug flag, without setting the error flag
#one parameter: string to be displayed
sub debug {
    my $self = shift(@_);
    if ( $self->{debug} ) {
        $self->print( "<p>" . shift(@_) . "</p>" );
    }
}

#output an error to the content field, but continue to process output
#one parameter: error string (should be complete sentence(s) )
sub print_warning {
    my $self = shift(@_);
    $self->print( "<div><b>警告 (WARNING): " . shift(@_) . "</b></div>" );
}

#output an error to the content field and set a flag to bypass future processing
#one parameter: error string (should be complete sentence(s) )
sub print_error {
    my $self = shift(@_);
    $self->print( "<div><b>"
          . shift(@_)
          . "</b></div><div>請點擊瀏覽器上一頁按鈕並重新輸入。(Please press the back button and re-enter input.)</div>"
    );
    $self->{error} = 1;
}

#output HMMER findings and/or error (whatever's in {content}) to HTML
#no parameters
sub write_page {
    my $self = shift(@_);
    $self->{page}->header("訊號胜肽預測工具 (Signal Peptide Finder)");
    print $self->{content};
    $self->{page}->footer();
}
