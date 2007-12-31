package WWW::MobileCarrierJP::EZWeb::Model;
use strict;
use warnings;
use utf8;
use Web::Scraper;
use URI;

sub scrape {
    my $url = "http://www.au.kddi.com/ezfactory/tec/spec/new_win/ezkishu.html";
    my $uri = URI->new($url);
    my $scraper = scraper {
        process '//tr[@valign="middle" and @bgcolor="#ffffff"]', 'devices[]' => scraper {
            process '//td[position()=1]', 'model_long', 'TEXT';
            process '//td[position()=2]', 'browser_type', 'TEXT';

            process '//td[position()=3]', 'is_color',
              [ 'TEXT', sub { /モノクロ/ ? undef : 1 } ];
            process '//td[position()=5]', 'display_browsing',
              [ 'TEXT', sub { /^(\d+)×(\d+)$/; +{width => $1, height => $2 } } ];
            process '//td[position()=6]', 'display_wallpaper',
              [ 'TEXT', sub { /^(\d+)×(\d+)$/; +{width => $1, height => $2 } } ];
            process '//td[position()=7]', 'gif',
              [ 'TEXT', sub { /○/ ? 1 : undef } ];
            process '//td[position()=8]', 'jpeg',
              [ 'TEXT', sub { /○/ ? 1 : undef } ];
            process '//td[position()=9]', 'png',
              [ 'TEXT', sub { /○|△/ ? 1 : undef } ];
            process '//td[position()=12]', 'flash_lite',
              [ 'TEXT', sub { /●/ ? '2.0' : (/◎|○/ ? '1.1' : undef) } ];
        };
    };
    $scraper->scrape($uri)->{devices};
}

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::EZWeb::Model - get Model informtation from EZWeb site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::EZWeb::Model;
    WWW::MobileCarrierJP::EZWeb::Model->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

