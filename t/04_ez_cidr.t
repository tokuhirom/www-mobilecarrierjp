use strict;
use warnings;
use Test::More tests => 4;
use WWW::MobileCarrierJP::EZWeb::CIDR;

my $dat = WWW::MobileCarrierJP::EZWeb::CIDR->scrape;
is ref($dat), 'ARRAY';
ok scalar(@$dat) > 10;
is scalar(grep /^[0-9\.]+$/, map { $_->{ip} } @$dat), scalar(@$dat);
is scalar(grep m{^/[0-9]+$}, map { $_->{subnetmask} } @$dat), scalar(@$dat);

