package WWW::MobileCarrierJP::ThirdForce::CIDR;
use strict;
use warnings;
use Web::Scraper;
use URI;

my $url = 'http://developers.softbankmobile.co.jp/dp/tech_svc/web/ip.php';

sub scrape {
    scraper {
        process '//td[@bgcolor="#eeeeee"]/font[@size="2" and @class="j10"]', 'cidr[]', ['TEXT', sub {
                        m{^([0-9.]+)(/[0-9]+)};
                        +{ ip => $1, subnetmask => $2 };
                    }];
    }->scrape(URI->new($url))->{cidr};
}

1;
