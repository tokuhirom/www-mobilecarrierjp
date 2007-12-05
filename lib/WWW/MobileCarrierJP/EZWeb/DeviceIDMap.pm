package WWW::MobileCarrierJP::EZWeb::DeviceIDMap;
use strict;
use warnings;
use URI;
use Web::Scraper;

sub scrape {
    my $url = 'http://www.au.kddi.com/ezfactory/tec/spec/4_4.html';
    my $uri = URI->new($url);

    my $scraper = scraper {
        process 'td > table > tr[bgcolor="#ffffff"]', 'models[]', scraper {
            process
                'tr[bgcolor="#ffffff"] > td[bgcolor="#f2f2f2"] > div.TableText',
                'model', 'TEXT';
            process
                '//tr[@bgcolor="#ffffff"]/td[@bgcolor!="#f2f2f2"]/div[@class="TableText"]',
                'device_id' => sub {
                    my $elem = shift;
                    my $text = $elem->as_text;
                    return if $text =~ /HTTP_USER_AGENT/;
                    $text =~ m{/} ? [ split( m{/}, $text ) ] : $text;
            };
        };
    };

    return [
        grep { $_->{device_id} && (ref $_->{device_id} eq 'ARRAY' || $_->{device_id} =~ /^.{4}$/) }
            @{ $scraper->scrape($uri)->{models} }
    ];
}

1;
