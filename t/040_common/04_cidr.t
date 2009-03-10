use strict;
use warnings;
use Test::More tests => 4*4;

my @carrier = qw/EZWeb DoCoMo AirHPhone ThirdForce/;
for my $carrier (@carrier) {
    my $class = "WWW::MobileCarrierJP::${carrier}::CIDR";

    eval "use $class"; ## no critic.
    die $@ if $@;

    my $dat = $class->scrape;
    is ref($dat), 'ARRAY', "$carrier: type check";
    ok scalar(@$dat) >= 7;
    is scalar(grep /^[0-9\.]+$/, map { $_->{ip} } @$dat), scalar(@$dat);
    is scalar(grep m{^/[0-9]+$}, map { $_->{subnetmask} } @$dat), scalar(@$dat);
}
