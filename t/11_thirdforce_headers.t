use strict;
use warnings;
use Test::More;
use WWW::MobileCarrierJP::ThirdForce::HTTPHeader;

my $rows = WWW::MobileCarrierJP::ThirdForce::HTTPHeader->scrape();

my @cases = (
    {
        'model'            => '831P',
        'x-jphone-color'   => 'C262144',
        'x-jphone-display' => '240*427',
        'x-jphone-name'    => '831P',
        'x-jphone-smaf'    => '40/pcm',
        'x-jphone-sound'   => undef,
    },
    {
        'model'            => '930CA',
        'x-jphone-color'   => 'C262144',
        'x-jphone-display' => '480*854',
        'x-jphone-name'    => '930CA',
        'x-jphone-smaf'    => '128/pcm',
        'x-jphone-sound'   => undef,
    },
    {
        'model'            => '830SH for Biz',
        'x-jphone-color'   => 'C262144',
        'x-jphone-display' => '240*320',
        'x-jphone-name'    => '830SHe',
        'x-jphone-smaf'    => '40/pcm/grf/rs',
        'x-jphone-sound'   => undef,
    },
    {
        'model'            => 'DM001SH',
        'x-jphone-color'   => 'C262144',
        'x-jphone-display' => '240*400',
        'x-jphone-name'    => 'DM001SH',
        'x-jphone-smaf'    => '40/pcm/grf/rs',
        'x-jphone-sound'   => undef,
    },
    {
        'model'            => '820SC',
        'x-jphone-name'    => '820SC',
        'x-jphone-color'   => 'C262144',
        'x-jphone-display' => '240*320',
        'x-jphone-smaf'    => '64/pcm',
        'x-jphone-sound'   => undef,
    },
    {
        'model'            => '706SC',
        'x-jphone-name'    => '706SC',
        'x-jphone-color'   => 'C262144',
        'x-jphone-display' => '240*320',
        'x-jphone-smaf'    => '64/pcm',
        'x-jphone-sound'   => undef,
    },
    {
        'model'            => 'J-SH02',
        'x-jphone-color'   => 'C256',
        'x-jphone-display' => '96*84',
        'x-jphone-name'    => 'J-SH02',
        'x-jphone-smaf'    => undef,
        'x-jphone-sound'   => '3.0',
    }
);

plan tests => 2*@cases;

for my $expected (@cases) {
    my ($got, ) = grep { $expected->{model} eq $_->{model} } @$rows;
    ok $got, "got $expected->{model}";
    is_deeply $got, $expected;
}

