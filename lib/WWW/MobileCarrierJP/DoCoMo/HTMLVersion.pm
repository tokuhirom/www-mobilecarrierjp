package WWW::MobileCarrierJP::DoCoMo::HTMLVersion;
use strict;
use warnings;
use Web::Scraper;
use URI;
use Encode;
use charnames ':full';

my $uri = URI->new("http://www.nttdocomo.co.jp/service/imode/make/content/spec/useragent/");

sub scrape {
    my $scraper = scraper {
        process '//div[@class="titlept01"]/../../div[@class="section"]', 'versions[]', scraper {
            process 'h2.title', 'version',
              [ 'TEXT', sub { s/^.*(\d\.\d).*$/$1/ } ];

            process '//td[@class!="acenter middle" and @class!="brownLight acenter middle" and 0=count(preceding-sibling::td[@class!="acenter middle"])]',
              'models[]',
              [
                sub {
                    # I want first text element in <td>
                    $_ = $_->content->[0]; # get span
                    $_ = $_->content->[0]; # get text
                    $_;
                },
                sub {
                    s/\x{a0}.*$//; # cut after space
                    s/\N{FULLWIDTH LEFT PARENTHESIS}.*//;
                    s/\N{GREEK SMALL LETTER MU}/myu/;
                    $_;
                }
              ];
        };
    };

    $scraper->scrape($uri)->{versions};
}

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::DoCoMo::HTMLVersion - get HTMLVersion informtation from DoCoMo site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::DoCoMo::HTMLVersion;
    WWW::MobileCarrierJP::DoCoMo::HTMLVersion->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

