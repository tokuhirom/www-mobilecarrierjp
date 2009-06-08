use strict;
use warnings;
use Test::More tests => 6;
use WWW::MobileCarrierJP::DoCoMo::UserAgent;

my $dat = WWW::MobileCarrierJP::DoCoMo::UserAgent->scrape;
ok ref($dat), 'ARRAY';
cmp_ok scalar(@$dat), '>', 30;

{
    my ($m, ) = grep { $_->{model} eq 'F-09A' } @$dat;
    ok $m;
    is $m->{user_agent}, 'DoCoMo/2.0 F09A3(c500;TB;W24H16)';
}

ok grep { $_->{model} eq 'P704Imyu' } @$dat;
is scalar(grep { $_->{model} =~ /&mu;/i } @$dat), 0;

