use strict;
use warnings;
use Test::More tests => 4;
use WWW::MobileCarrierJP::EZWeb::Model;

my $info = WWW::MobileCarrierJP::EZWeb::Model->scrape;
is ref($info), 'ARRAY';
ok scalar(@$info) > 30;
ok scalar(grep /1/, map { $_->{is_color} } @$info) > 30;
is scalar(grep /0/, map { $_->{is_color} } @$info), 8;

