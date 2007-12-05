use strict;
use warnings;
use Test::More tests => 2;
use WWW::MobileCarrierJP::DoCoMo::DisplayMap;

my $dat = WWW::MobileCarrierJP::DoCoMo::DisplayMap->scrape;
ok scalar(@$dat) > 30;
is scalar(grep { $_->{model} eq 'D905i' } @$dat), 1;

