package WWW::MobileCarrierJP::DoCoMo::Flash;
use strict;
use warnings;
use utf8;
use charnames ':full';
use Encode;
use LWP::UserAgent;
use Web::Scraper;
use URI;

my $URL = 'http://www.nttdocomo.co.jp/service/imode/make/content/spec/flash/index.html';

sub scrape {
    scraper {
        process '//div[position()<7]/div/div[@class="section"]', 'versions[]', scraper {
            process '//h2/a/text()', 'version', ['TEXT', sub { s/^Flash Lite // }];
            process '//tr[@class="acenter"]', 'models[]', [sub {
                my $elem = $_;
                my $tree = _as_tree($elem);
                $_->delete for $tree->findnodes('//td[@class="brownLight acenter middle"]');
                # remove series info.

                scraper {
                    process '//td[position()=1]', 'model', [
                        'TEXT', sub { s/\N{GREEK SMALL LETTER MU}/myu/; s/\（.+）// }, sub { uc }
                    ];
                    process '//td[position()=3]', 'standby_screen', [
                        'TEXT', sub {
                            /(\d+)×(\d+)/; +{width=>$1, height => $2}
                        }];
                    process '//td[position()=2]', 'browser', [
                        'TEXT', sub {
                            my @size;
                            while (/(\d+)×(\d+)/g) {
                                push @size, +{width=>$1, height => $2}
                            }
                            \@size;
                        }];
                    process '//td[position()=4]', 'working_memory_capacity', 'TEXT';
                }->scrape($tree);
            }];
        };
    }->scrape(URI->new($URL))->{versions};
}

sub _as_tree {
    my $self = shift;

    my $tree = HTML::TreeBuilder::XPath->new;
    $tree->parse($self->as_HTML);
    $tree;
}

1;
__END__

=head1 SEE ALSO

L<http://www.nttdocomo.co.jp/english/service/imode/make/content/spec/flash/index.html>
