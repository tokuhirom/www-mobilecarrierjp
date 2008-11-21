package WWW::MobileCarrierJP::DoCoMo::Display;
use strict;
use warnings;
use utf8;
use LWP::UserAgent;
use Encode;
use Carp;

my $URL = 'http://www.nttdocomo.co.jp/service/imode/make/content/spec/screen_area/index.html';

sub scrape {
    my $html = decode( 'cp932', _get($URL) );
    $html =~ s/(?:\r?\n)+/\n/g;
    $html =~ s/&mu;/myu/g;
    my $re = _regexp();
    my $map;
    while ( $html =~ /$re/igs ) {
        my ( $model, $width, $height, $color, $depth ) = ( $1, $2, $3, $4, $5 );

        push @$map, {
            model    => $model,
            width    => $width,
            height   => $height,
            is_color => $color eq 'カラー',
            depth    => $depth,
        };
    }
    $map;
}

sub _get {
    my $url = shift;
    my $ua  = LWP::UserAgent->new( agent => __PACKAGE__ );
    my $res = $ua->get($url);
    if ( $res->is_success ) {
        return $res->content;
    }
    else {
        croak $res->status_line;
    }
}

sub _regexp {
    return <<'RE';
<td(?: colspan="2")?><span class="txt">([A-Z]+-?\d+\w*\+?).*?</span></td>
<td><span class="txt">.*?(?:</span></td>)?
<td><span class="txt">.*?(?:</span></td>)?
<td><span class="txt">.*?(\d+)×(\d+).*?</span></td>
<td>.*?</td>
<td><span class="txt">(白黒|カラー)(?:.*?)(\d+)(?:色|階調)</span></td>
RE
}

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::DoCoMo::Display - get display informtation from DoCoMo site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::DoCoMo::Display;
    WWW::MobileCarrierJP::DoCoMo::Display->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 THANKS

This code is copied from HTTP::MobileAgent :)

thanks H-MA authors.

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

