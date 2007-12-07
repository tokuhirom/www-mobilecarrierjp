use strict;
use warnings;
use Test::More tests => 13;
use WWW::MobileCarrierJP::EZWeb::Model;

my $info = WWW::MobileCarrierJP::EZWeb::Model->scrape;
is ref($info), 'ARRAY';
ok scalar(@$info) > 30;

ok scalar( grep { $_ } map { $_->{is_color} } @$info ) > 30, 'color';
is scalar( grep { not defined $_ } map { $_->{is_color} } @$info ), 8;

cmp_ok scalar( grep { $_ } map { $_->{gif} } @$info ), '>', 30, 'gif';
is scalar( grep { not defined $_ } map { $_->{gif} } @$info ), 56;

cmp_ok scalar( grep { $_ } map { $_->{png} } @$info ), '>', 30, 'png';
is scalar( grep { not defined $_ } map { $_->{png} } @$info ), 7;

cmp_ok scalar( grep { $_ } map { $_->{jpeg} } @$info ), '>', 30, 'jpeg';
is scalar( grep { not defined $_ } map { $_->{jpeg} } @$info ), 35;

cmp_ok scalar( grep { $_ && $_ eq '2.0' } map { $_->{flash_lite} } @$info ), '>', 30, 'flash lite 2.0';
is scalar( grep { $_ && $_ eq '1.1' } map { $_->{flash_lite} } @$info ), 51, 'flash lite 1.1';
is scalar( grep { not defined $_ } map { $_->{jpeg} } @$info ), 35, 'no flash lite';

