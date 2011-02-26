package WWW::MobileCarrierJP::Softbank::Service;
use strict;
use warnings;
use utf8;
use charnames ':full';
use WWW::MobileCarrierJP::Declare;

my $url = 'http://creation.mb.softbank.jp/terminal/?lup=y&cat=service';
my $xpath = '//div/table/tr/td/table[@bordercolor="#999999"]/tr[not(@bgcolor="#ee9abb") and not(@bgcolor="#cccccc") and count(child::td) != 1]';

parse_one(
    urls    => [$url],
    xpath   => $xpath,
    scraper => scraper {
        col 1 => 'model', 'TEXT';
        col 2 => 'sappli',        [ 'TEXT', \&_marubatsu ];
        col 3 => 'mobile_widget', [ 'TEXT', \&_marubatsu ];
     #  col 4 => 'flashlite' => [
     #      'TEXT',
     #      sub { s/^Flash Lite\N{TRADE MARK SIGN}// },
     #      sub { s/\s// },
     #      sub { $_ = undef if /\N{MULTIPLICATION SIGN}/ },    # `x' case.
     #  ];
        col 4 => 'gps_basic',  [ 'TEXT', \&_marubatsu ];
        col 5 => 'gps_agps',   [ 'TEXT', \&_marubatsu ];
        col 6 => 'felica',     [ 'TEXT', \&_marubatsu ];
        col 7 => 'pc_browser', [ 'TEXT', \&_marubatsu ];
    },
);

sub _marubatsu { $_ = $_ =~ /\N{WHITE CIRCLE}|\N{BULLSEYE}/ ? 1 : 0 }

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::Softbank::Service - get Service informtation from Softbank site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::Softbank::Service;
    WWW::MobileCarrierJP::Softbank::Service->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

