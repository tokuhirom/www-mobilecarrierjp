package WWW::MobileCarrierJP::DoCoMo::CIDR;
use strict;
use warnings;
use Web::Scraper;
use URI;

my $url = 'http://www.nttdocomo.co.jp/service/imode/make/content/ip/';

sub scrape {
    scraper {
        process '//div[@class="boxArea" and count(preceding-sibling::*)=2]/div/div[@class="section"]/ul[@class="normal txt"]/li',
                'cidr[]', [
                    'TEXT', sub {
                        m{^([0-9.]+)(/[0-9]+)};
                        +{ ip => $1, subnetmask => $2 };
                    }
                ];
    }->scrape(URI->new($url))->{cidr};
}

1;
