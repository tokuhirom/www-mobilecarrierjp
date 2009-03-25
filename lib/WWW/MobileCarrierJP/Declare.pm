package WWW::MobileCarrierJP::Declare;
use strict;
use warnings;
use utf8;
use base qw/Exporter/;
use Web::Scraper;
use URI;
BEGIN {
    eval q{
        use HTML::TreeBuilder::LibXML;
        HTML::TreeBuilder::LibXML->replace_original();
    };
}

our @EXPORT = qw(parse_one scraper process col as_tree result);

sub import {
    my $class = shift;

    strict->import;
    warnings->import;
    utf8->import;

    $class->export_to_level(1);
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
        my $urls = $args{urls} or die "missing urls";
        for my $url ( @$urls ) {
            my $result = scraper {
                process $args{xpath}, 'rows[]', $args{scraper};
            }->scrape( URI->new($url) )->{rows};

            push @res, @$result;
        }
        return \@res;
    };
}

sub as_tree {
    my $old = shift;

    my $tree = HTML::TreeBuilder::XPath->new;
    $tree->parse($old->as_HTML);
    $tree;
}


1;
