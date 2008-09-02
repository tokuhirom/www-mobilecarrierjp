package WWW::MobileCarrierJP::Declare;
use strict;
use warnings;
use utf8;
use Web::Scraper;
use URI;
use Sub::Exporter;

my $exporter = Sub::Exporter::build_exporter(
    {
        exports => [qw(parse_one scraper process col)],
        groups  => { default => [':all'] }
    },
);

sub import {
    strict->import;
    warnings->import;
    utf8->import;

    goto $exporter;
}

sub col {
    my ($n, @args) = @_;
    process "td:nth-child($n)", @args;
}

sub parse_one {
    my %args = @_;

    my $pkg = caller(0);
    no strict 'refs';

    *{"$pkg\::scrape"} = sub {
        my @res = ();
        for my $url (@{ $args{urls} }) {
            my $result = scraper {
                process $args{xpath}, 'rows[]', $args{scraper};
            }->scrape( URI->new($url) )->{rows};

            push @res, @$result;
        }
        return \@res;
    };

}

1;
