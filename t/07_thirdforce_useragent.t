use strict;
use warnings;
use Test::More tests => 11;
use WWW::MobileCarrierJP::ThirdForce::UserAgent;

my $dat = WWW::MobileCarrierJP::ThirdForce::UserAgent->scrape;
ok ref($dat), 'ARRAY';
cmp_ok scalar(@$dat), '>', 30;

is $dat->[0]->{model}, 'V403SH';
is $dat->[0]->{user_agent}, 'J-PHONE/3.0/V403SH';
is $dat->[0]->{msname}, 'V403SH';
is $dat->[0]->{display}->{width}, 240;
is $dat->[0]->{display}->{height}, 260;
is $dat->[0]->{is_color}, 1;
is $dat->[0]->{color}, 262144;

ok grep { $_->{model} eq '821P' } @$dat;
is scalar(grep { $_->{model} =~ /series/ } @$dat), 0;

