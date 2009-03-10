use strict;
use warnings;
use Test::More tests => 3;
use WWW::MobileCarrierJP::DoCoMo::Display;

my $dat = WWW::MobileCarrierJP::DoCoMo::Display->scrape;
ok scalar(@$dat) > 30;
is scalar(grep { $_->{model} eq 'D905i' } @$dat), 1;
is scalar(grep { $_->{model} eq 'F-01A' } @$dat), 1;
