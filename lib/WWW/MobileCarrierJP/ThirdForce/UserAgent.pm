package WWW::MobileCarrierJP::ThirdForce::UserAgent;
use strict;
use warnings;
use URI;
use Web::Scraper;

my @urls = map { URI->new($_) } map {
    "http://developers.softbankmobile.co.jp/dp/tech_svc/info/useragent.php?page=$_"
} ( 1 .. 4 );

sub scrape {
    my $s = scraper {
        process '//table[@width="100%"]/tr[position()>2]', 'models[]', scraper {
            process 'td:nth-child(1)', 'model', 'TEXT';
            process 'td:nth-child(2)', 'user_agent', 'TEXT';
            process 'td:nth-child(3)', 'msname', 'TEXT';
            process 'td:nth-child(4)', 'display', ['TEXT', sub {
                /^(\d+)\*(\d+)$/; +{ width => $1, height => $2 };
            }];
            process 'td:nth-child(5)', 'is_color', ['TEXT', sub {
                /^C/ ? 1 : 2
            }];
            process 'td:nth-child(5)', 'color', ['TEXT', sub {
                s/^[CG]//;
            }];
            process 'td:nth-child(8)', 'java', ['TEXT', sub {
                /1/ ? 1 : undef
            }];
        };
    };

    my $result;
    for my $uri (@urls) {
        push @$result, @{$s->scrape($uri)->{models}};
    }
    return [grep { $_->{model} !~ /series/ } @$result ];
}

1;
