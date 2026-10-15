
=head1 add_post.pl

add_post.pl adds posts to topics or comments to webpages. 

For the former, add_post.pl takes a topic_id parameter. For the latter, add_post takes two parameters, page_type and page_object_id. If not parameter is specified, add_post.pl shows an error message. If all three parameters are specified, the topic_id overrides the other two.

If no post_text is supplied, add_post.pl displays an input mask. Otherwise it processes the entry and tries to add post_text to the database, with the logged in user as the submitter and the topic id as specified above.

A refering_page parameter can be used to generate a link back to the calling page.

=cut
    
use strict;
use utf8;

use CXGN::Page;
use CXGN::DB::Connection;
use CXGN::Login;
use CXGN::People;
use CXGN::People::Forum;
use CXGN::People::Person;
use CXGN::Page::FormattingHelpers qw/  page_title_html
                                     blue_section_html  /;

my $SIZELIMIT = 10000; # the maximal number of bytes in a post.

my $page = CXGN::Page->new( "SGN 論壇 | 新增貼文 (Add Post)", "Lukas");
my $dbh = CXGN::DB::Connection->new();

#
# get information about the poster
#
my ( $person, $name, $sp_person_id ) = do {
    # to enable anonymous comments, change the verify_session to has_session
    if( my $sp_person_id = CXGN::Login->new($dbh)->verify_session ) {
        my $person = CXGN::People::Person -> new($dbh, $sp_person_id);
        my $name = $person->get_first_name()." ".$person->get_last_name();
        $sp_person_id = $person -> get_sp_person_id();
        ( $person, $name, $sp_person_id )
    } else {
        ( (undef) x 3 )
    }
};


my ($subject, $post_text, $parent_post_id, $topic_id, $page_type, $page_object_id, $refering_page, $action) = $page -> get_encoded_arguments("subject", "post_text", "parent_post_id", "topic_id", "page_type", "page_object_id", "refering_page", "action");

# we define 3 actions: 
# 1) input
# 2) review
# 3) save
# all other values for the action parameter will show the input as default.


my $parent_post = "";
my $parent_subject = "";
my $display_subject = "";
my $parent_post_text = "";
my $parent_post_explain = "";
my $topic;
my $topic_name = "";
my $subject_input = ""; 
#
# if a topic_id is supplied, simply add the post to the given topic id.
#
if ($topic_id) { 
    $parent_post = CXGN::People::Forum::Post -> new($dbh, $parent_post_id);
    $parent_subject = $parent_post->get_subject();
    $parent_post_text = $parent_post->get_post_text();
    $parent_post_explain = "";
    $display_subject = "RE: $parent_subject";
    if ($parent_post_text) { 
	$parent_post_explain = "您的訊息將附加於以下訊息 (Your message will be attached to the following message): 
	<table summary=\"\" class=\"sgnblue\"><tr><td><pre>$parent_post_text</pre></td></tr></table>
	<br />";
	$subject_input = "<input type=\"text\" name=\"subject\" value=\"$display_subject\" /><br /><br /> ";
    }

    $topic = CXGN::People::Forum::Topic -> new($dbh, $topic_id);
    if (!$topic) { 
	$page->error_page("未提供有效的主題 ID (No legal topic id was supplied)。[topic_id=$topic_id]");
    }
    $topic_name =  $topic -> get_topic_name();
}
#
# if the page_type and page_object_id are supplied, it is a page comment. Get the 
# topic id for that page and id.
#
elsif ($page_type && $page_object_id) { 
    $topic = CXGN::People::Forum::Topic->new_page_comment($dbh, $page_type, $page_object_id);
    if (!$topic->get_topic_name()) { 
	$topic->set_topic_name($page_type." ".$page_object_id); 
	$topic->set_person_id($sp_person_id);

    }
    $topic_name = "$page_type id: $page_object_id";
}
else
{
    $page->error_page("抱歉，新增此貼文的資料不足 (Sorry, but there was insufficient data to add this post)。");    
}

#
# create a post object to work from
#
my $post = CXGN::People::Forum::Post->new($dbh);
$post->set_subject($subject);
$post->set_person_id($sp_person_id);
$post->set_parent_post_id($parent_post_id);
$post->set_forum_topic_id($topic_id);
my $formatted_post_text = $post->format_post_text($post_text);

# 
# create $link with a link back to the original posting page
# (this can be a detail page or it can be a topic_id specific posts.pl page
#
my $link;
if ($refering_page) { 
    $link = "<a href=\"$refering_page\">返回貼文列表 (Back to posts)</a>"; 
}
else { 
    $link = "<a href=\"posts.pl?topic_id=$topic_id\">返回貼文列表 (Back to posts)</a>";
}
#
# perform the appropriate action, depending on the
# action parameter
#
if ($action eq "review") {    

    my $truncated = 0;
    my $display_post_text = "";
    if (length($post_text)>$SIZELIMIT) { 
	$display_post_text = substr($post_text, 0, $SIZELIMIT);
	$truncated = 1;
    }
    else { 
	$display_post_text = $post_text; 
    }
    
    my $truncated_warning = "";
    if ($truncated) { 
	$truncated_warning = "<b>提示 (Note):</b> 您的貼文超過 $SIZELIMIT 個字元，已被截斷。請點擊「修改貼文」返回修改，或送出以接受截斷後的版本。<br /><br />\n";
    }


    $page -> header();

    print page_title_html("審閱您的貼文 (Review your post)");
    
    print <<HTML;
    <div class="container-fluid">
    輸入貼文 (Enter post) -> <b>審閱貼文 (Review post)</b> -> 儲存貼文 (Store post)<br /><br />
    以下為您貼文文字的呈現樣式。請使用「儲存貼文」按鈕永久新增貼文，或使用「修改貼文」按鈕返回修改。若要取消，請點擊「返回貼文列表」。<br /><br />
 
    $truncated_warning

    <div class="panel panel-primary"><div class="panel-body">$formatted_post_text</div></div>

    <br /><br />

    <table width="100%"><tr><td align="left">
    <form action="add_post.pl" method="post">
    <input type="hidden" name="post_text" value="$post_text" />
    <input type="hidden" name="page_type" value="$page_type" />
    <input type="hidden" name="page_object_id" value="$page_object_id" />
    <input type="hidden" name="refering_page" value="$refering_page" />
    <input type="hidden" name="action" value="input" />
    <input type="hidden" name="topic_id" value="$topic_id" />
    <input class="btn btn-info" type="submit" value="修改貼文 (Modify post)" />
    </form>
    <td><td>
    $link
    </td><td align="right">
    <form action="add_post.pl" method="post">
    <input type="hidden" name="post_text" value="$post_text" />
    <input type="hidden" name="page_type" value="$page_type" />
    <input type="hidden" name="page_object_id" value="$page_object_id" />
    <input type="hidden" name="refering_page" value="$refering_page" />
    <input type="hidden" name="action" value="save" />
    <input type="hidden" name="topic_id" value="$topic_id" />
    <input class="btn btn-primary" type="submit" value="儲存貼文 (Store post)" />
    </form>
    </td></tr></table>
    </div>
HTML

    $page -> footer();
}

elsif ($action eq "save") {
    #
    # save the object if action is "save"
    #
    $topic->set_page_type($page_type);
    $topic->set_page_object_id($page_object_id);
    $topic->store();

    $topic_id = $topic->get_forum_topic_id();
    $post->set_forum_topic_id($topic_id);

    my $truncated = 0;
    if (length($post_text)>$SIZELIMIT) { 
	$post_text = substr($post_text, 0, $SIZELIMIT);
	$truncated = 1;
    }

    $post->set_post_text($post_text);
    $post->store();

    $page->header();

    print page_title_html("您的貼文已成功儲存 (Your post was successfully stored)");
    print "輸入貼文 (Enter post) -> 審閱貼文 (Review post) -> <b>儲存貼文 (Store post)</b><br /><br />\n";

    if ($truncated) { 
	print "<b>提示 (Note):</b> 您的貼文已被截斷至 $SIZELIMIT 個字元。<br />\n";
    }

    my $display_post_text = $post->format_post_text($post_text);
    #print "submitter: $sp_person_id topic: $topic_id, $page_type, $page_object_id. text:<br /><br />";
    print "<div class=\"panel panel-primary\" ><div class=\"panel-body\">$display_post_text</div></div>";
    print "<br /><br /><br />\n";
    
 
    print "$link<br /><br /><br />\n";

    $page->footer();

}

else { 
    #
    # the action is "input" or anything else. 
    #
    $page -> header();

    print page_title_html("輸入主題 \"$topic_name\" 的貼文 (Enter Post for topic \"$topic_name\")");

    print <<HTML;

    <form method="post" action="add_post.pl">
	
	步驟 (Steps): <b>輸入貼文 (Enter post)</b> -> 審閱貼文 (Review post) -> 儲存貼文 (Store post)<br /><br /> 
	$parent_post_explain<br />
	
	請在下方輸入您的評論。登入後您隨時可以刪除此貼文。<br />
	不支援 HTML 標籤。您可以使用方括號新增連結，例如：<br />
	<tt>[url]sgn.cornell.edu[/url]</tt> 這在貼文中將顯示為 <a href="http://sgn.cornell.edu">sgn.cornell.edu</a>。<br /><br />

	每則貼文的大小限制為 $SIZELIMIT 個字元（包含空格與標點符號）。<br /><br />
	<b>注意事項 (Note):</b> 此服務由 SGN 免費提供。SGN 保留隨時因任何原因刪除貼文的權利。
	<br /><br />
	<input type="hidden" name="parent_post_id" value="$parent_post_id" />
	<input type="hidden" name="topic_id" value="$topic_id" />
	<input type="hidden" name="page_type" value="$page_type" />
	<input type="hidden" name="page_object_id" value="$page_object_id" />
	<input type="hidden" name="refering_page" value="$refering_page" />
	<input type="hidden" name="action" value="review" />
	$subject_input

	貼文內容 (Post Text):<br />
	<textarea class="form-control" rows="12" cols="80" name="post_text">$post_text</textarea>
	<br /><br />

	<table width="100%"><tr><td align="left">
	$link 
	</td><td align="right">
	<input class="btn btn-primary" type=submit value="審閱貼文 (Review post)" />
	</form>
	</td></tr></table>

	<br />
	
      
      <br />
      <br />

HTML

      $page->footer();

}





