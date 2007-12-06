package WWW::MobileCarrierJP::AirHPhone::CIDR;
use strict;
use warnings;
use Web::Scraper;
use URI;

my $url = 'http://www.willcom-inc.com/ja/service/contents_service/club_air_edge/for_phone/ip/';

sub scrape {
    scraper {
        process '//td[@width="50%"]/font[@size="2"]', 'cidr[]', ['TEXT', sub {
                        m{^([0-9.]+)(/[0-9]+)};
                        +{ ip => $1, subnetmask => $2 };
                    }];
    }->scrape(URI->new($url))->{cidr};
}

1;
