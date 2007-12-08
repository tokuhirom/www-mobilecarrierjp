use strict;
use warnings;
use Test::More tests => 6;
use WWW::MobileCarrierJP::EZWeb::DeviceID;

my $dat = WWW::MobileCarrierJP::EZWeb::DeviceID->scrape;
ok scalar(@$dat) > 30;
is scalar(grep { $_->{device_id} =~ /HTTP/ } @$dat), 0;
is scalar(grep { $_->{device_id} eq '' } @$dat), 0;
is(get_device_id('W43T'), 'TS36', 'single');
is_deeply(get_device_id('W32S'), [qw/SN33 SN35/], 'double');
is(get_device_id('W53SA'), 'ST32', 'single');

sub get_device_id {
    my $model = shift;
    my ($ret, ) = map { $_->{device_id} } grep { $_->{model} eq $model } @$dat;
    $ret;
}
