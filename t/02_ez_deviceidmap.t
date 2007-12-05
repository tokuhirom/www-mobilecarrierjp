use strict;
use warnings;
use Test::More tests => 4;
use WWW::MobileCarrierJP::EZWeb::DeviceIDMap;

my $dat = WWW::MobileCarrierJP::EZWeb::DeviceIDMap->scrape;
ok scalar(@$dat) > 30;
is scalar(grep { $_->{device_id} =~ /HTTP/ } @$dat), 0;
is_deeply(get_device_id('W43T'), 'TS36', 'single');
is_deeply(get_device_id('W32S'), [qw/SN33 SN35/], 'double');

sub get_device_id {
    my $model = shift;
    map { $_->{device_id} } grep { $_->{model} eq $model } @$dat
}
