use strict;
use warnings;
use Test::More;
use WWW::MobileCarrierJP::EZWeb::BREW;
use LWP::Online ':skip_all';
plan tests => 4;

my $models = WWW::MobileCarrierJP::EZWeb::BREW->scrape;
is ref($models), 'ARRAY';

is scalar( grep { $_ eq '2.0' } map { $_->{version} } @$models ), 6, '2.0';
cmp_ok scalar( grep { $_ eq '3.1' } map { $_->{version} } @$models ), '>=', 31, '3.1';
cmp_ok scalar( grep { $_ eq '4.0' } map { $_->{version} } @$models ), '>=', 3, '4.0';
