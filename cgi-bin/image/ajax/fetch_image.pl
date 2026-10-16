
use strict;
use warnings;
use utf8;

use CGI;
use JSON;
use CXGN::DB::Connection;
use SGN::Image;

use CatalystX::GlobalContext '$c';

eval {
    my $q = CGI->new();
    my $image_id = $q->param("image_id");
    my $size = $q->param("size");
    
    my $image = SGN::Image->new( undef, $image_id, $c );
    
    my $html = $image->get_img_src_tag($size);
    
    print "Content-Type: application/json; charset=UTF-8\n\n";
    print  to_json({ html=>$html });

};

if ($@) { 
    print "Content-Type: text/plain\n\nerror: $@\n\n";
}
