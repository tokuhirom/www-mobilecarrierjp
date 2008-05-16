package WWW::MobileCarrierJP::ThirdForce::Service;
use strict;
use warnings;
use utf8;
use charnames ':full';
use boolean ':all';
use Web::Scraper;
use URI;

my $url_tmpl = 'http://creation.mb.softbank.jp/terminal/spec_serv_%02d.html';

sub scrape {
    my @ret = ();
    for my $i (1..4) {
        push @ret, @{ _get_page($i) };
    }
    \@ret;
}

sub _get_page {
    my $i = shift;
    my $url = sprintf $url_tmpl, $i;
    my $rows = scraper {
        process '//div/table/tr/td/table[@bordercolor="#999999"]/tr[not(@bgcolor="#ee9abb") and not(@bgcolor="#cccccc") and count(child::td) = 7]', 'rows[]', scraper {
            process 'td:nth-child(1)' => 'model', 'TEXT';
            process 'td:nth-child(2)' => 'flashlite' => [
                'TEXT',
                sub { s/^Flash Lite\N{TRADE MARK SIGN}// },
                sub { s/\s// },
                sub { $_ = undef if /\N{MULTIPLICATION SIGN}/ }, # `x' case.
            ];
            process 'td:nth-child(3)' => 'sappli',     ['TEXT', \&_marubatsu];
            process 'td:nth-child(4)' => 'gps_basic',  ['TEXT', \&_marubatsu];
            process 'td:nth-child(5)' => 'gps_agps',   ['TEXT', \&_marubatsu];
            process 'td:nth-child(6)' => 'felica',     ['TEXT', \&_marubatsu];
            process 'td:nth-child(7)' => 'pc_browser', ['TEXT', \&_marubatsu];
        };
    }->scrape(URI->new($url))->{rows};
    $rows;
}

sub _marubatsu { $_ = $_ =~ /\N{WHITE CIRCLE}|\N{BULLSEYE}/ ? 1 : 0 }

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::ThirdForce::Service - get Service informtation from ThirdForce site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::ThirdForce::Service;
    WWW::MobileCarrierJP::ThirdForce::Service->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

