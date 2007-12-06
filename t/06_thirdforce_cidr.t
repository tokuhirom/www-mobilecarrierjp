use strict;
use warnings;
use Test::More tests => 4;
use WWW::MobileCarrierJP::ThirdForce::CIDR;

my $dat = WWW::MobileCarrierJP::ThirdForce::CIDR->scrape;
is ref($dat), 'ARRAY';
ok scalar(@$dat) >= 7;
is scalar(grep /^[0-9\.]+$/, map { $_->{ip} } @$dat), scalar(@$dat);
is scalar(grep m{^/[0-9]+$}, map { $_->{subnetmask} } @$dat), scalar(@$dat), 'check subnetmask';

