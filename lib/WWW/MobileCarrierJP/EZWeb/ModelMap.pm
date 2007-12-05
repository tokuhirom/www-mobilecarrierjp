package WWW::MobileCarrierJP::EZWeb::ModelMap;
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
            process '//td[position()=3]', 'is_color', sub {
                my $elem = shift;
                $elem->as_text eq 'モノクロ' ? 0 : 1;
            };
        };
    };
    $scraper->scrape($uri)->{devices};
}

1;
__END__

=head1 NOTE

だれかつづきつくってー

=head1 AUTHOR

Tokuhiro MATSUNO
