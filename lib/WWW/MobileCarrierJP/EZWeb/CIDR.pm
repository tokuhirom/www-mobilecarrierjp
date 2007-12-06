package WWW::MobileCarrierJP::EZWeb::CIDR;
use strict;
use warnings;
use Web::Scraper;
use URI;

my $url = 'http://www.au.kddi.com/ezfactory/tec/spec/ezsava_ip.html';

sub scrape {
    scraper {
        process '//table[@cellspacing="1"]/tr[@bgcolor="#ffffff"]', 'ip[]', scraper {
            process '//td[position()=2]/div', 'ip',         'TEXT';
            process '//td[position()=3]/div', 'subnetmask', 'TEXT';
        };
    }->scrape(URI->new($url))->{ip};
}

1;

