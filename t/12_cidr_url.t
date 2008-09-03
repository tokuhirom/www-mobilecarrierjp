use strict;
use warnings;
use Test::More tests => 4*1;

my @carrier = qw/EZWeb DoCoMo AirHPhone ThirdForce/;
for my $carrier (@carrier) {
    my $class = "WWW::MobileCarrierJP::${carrier}::CIDR";

    eval "use $class"; ## no critic.
    die $@ if $@;

    my $url = $class->url;
    ok $url =~ /^http/;
;
}
