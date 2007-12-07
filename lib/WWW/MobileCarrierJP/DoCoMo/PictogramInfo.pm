package WWW::MobileCarrierJP::DoCoMo::PictogramInfo;
use strict;
use warnings;
use HTML::Selector::XPath 0.03;
use Web::Scraper;
use URI;

my @url = (
    URI->new("http://www.nttdocomo.co.jp/service/imode/make/content/pictograph/basic/index.html"),
    URI->new("http://www.nttdocomo.co.jp/english/service/imode/make/content/pictograph/basic/index.html"),
    URI->new("http://www.nttdocomo.co.jp/service/imode/make/content/pictograph/extention/index.html"),
    URI->new("http://www.nttdocomo.co.jp/english/service/imode/make/content/pictograph/extention/index.html"),
);

sub scrape {
    my $res;
    my $i;
    my @prev;
    for my $uri (@url) {
        my $scraper = scraper {
            process 'tr', 'characters[]', scraper {
                process 'td:nth-child(3)', 'sjis', 'TEXT';
                process 'td:nth-child(5)', 'unicode', 'TEXT';
                process 'td:nth-child(6)', 'name',  'TEXT';
                process 'td:nth-child(7)', 'color', 'TEXT';
            };
        };
        my @chars = @{ $scraper->scrape($uri)->{characters} };

        # remove headers
        shift @chars; shift @chars;

        if (++$i % 2) {
            @prev = @chars;
        } else {
            @prev == @chars or die "ja/en count doesn't match";
            for my $c (0..$#prev) {
                for my $column (qw/color name/) {
                    $prev[$c]->{"en_$column"} = $chars[$c]->{$column};
                    $prev[$c]->{"jp_$column"} = delete $prev[$c]->{$column};
                }
            }
            push @$res, @prev;
        }
    }

    $res;
}

1;
__END__

=head1 THANKS

This code is copied from Encode-JP-Mobile.

miyagawa++

