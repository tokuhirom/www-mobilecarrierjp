package WWW::MobileCarrierJP::DoCoMo::HTMLVersion;
use strict;
use warnings;
use charnames ':full';
use WWW::MobileCarrierJP::Declare;
use HTML::TableExtract;

parse_one(
    urls => ["http://www.nttdocomo.co.jp/service/imode/make/content/spec/useragent/"],
    xpath => '//div[@class="titlept01"]/../../div[@class="section"]',
    scraper => scraper {
        process 'h2.title', 'version',
            [ 'TEXT', sub { s/^.*(\d\.\d).*$/$1/ } ];

        my $tree = $_->clone;
        $_->delete for $tree->findnodes('//td[contains(@class, "brownLight")]');
        $_->delete for $tree->findnodes('//a');
        my @models;
        for my $table ($tree->findnodes('//table')) {
            my $te = HTML::TableExtract->new();
            $te->parse($table->as_HTML);
            for my $row ($te->rows) {
                local $_ = $row->[1] || $row->[0];
                s/\x{a0}.*$//; # cut after space
                s/\n//g;
                s/\N{FULLWIDTH LEFT PARENTHESIS}.*//;
                s/\N{GREEK SMALL LETTER MU}/myu/;
                push @models, $_;
            }
        }

        return +{ models => \@models, version => result->{version} };
    },
);

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

