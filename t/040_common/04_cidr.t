use t::Utils;
use Test::More tests => 4 + 4*4 + 1;

for my $class (modules('CIDR')) {
    my $dat = $class->scrape;
    is ref($dat), 'ARRAY', "$class : type check";
    ok scalar(@$dat) >= 7;
    is scalar(grep /^[0-9\.]+$/, map { $_->{ip} } @$dat), scalar(@$dat);
    is scalar(grep m{^/[0-9]+$}, map { $_->{subnetmask} } @$dat), scalar(@$dat);
}

my $e = WWW::MobileCarrierJP::EZWeb::CIDR->scrape();
is scalar(grep { $_->{ip} eq '61.117.0.128'} @$e), 0, '廃止されたものは無視';

