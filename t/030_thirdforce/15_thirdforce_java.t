use strict;
use warnings;
use Test::Base;
use WWW::MobileCarrierJP::ThirdForce::Java;

plan tests => 2 + 2 * blocks;

my $dat = WWW::MobileCarrierJP::ThirdForce::Java->scrape;
is ref($dat), 'ARRAY';
is join(',', sort(keys %{$dat->[0]})), 'cldc,felica_api,heap,limit,location_api,midp,model,profile,size';

filters { info => [qw/yaml/] };

run {
    my $block = shift;
    check($block->info);
};

sub check {
    my ($info, ) = @_;
    my ($model, ) = grep { $_->{model} eq $info->{model} } @$dat;
    ok $model, "got a $info->{model} phone info";
    is_deeply $model => $info, "check the $info->{model}";
}

__END__

===
--- info
model   : 740SC
profile : ''
heap    :
    base : 0
    ex   : 0
location_api : ''
midp : ''
cldc : ''
limit : ''
felica_api : ''
size :
    rs : 0
    jad : 0
    jar : 0

===
--- info
model   : 940SH
profile : MEXA
heap    :
    base : 8388608
    ex   : 16777216
location_api : 1
midp : 2.0
cldc : 1.1
limit : 4194304
felica_api : 2.0
size :
    rs : 3145728
    jad : 6144
    jar : 1048576

===
--- info
model   : 840SH
profile : MEXA
heap    :
    base : 4194304
    ex   : 0
location_api : ''
midp : 2.0
cldc : 1.1
limit : 4194304
felica_api : ''
size :
    rs : 3145728
    jad : 6144
    jar : 1048576

===
--- info
model   : 904T
profile : JSCL 1.2.2
heap    :
    base : 4194304
    ex   : 0
location_api : 1
midp : 2.0
cldc : 1.1
limit : 4194304
felica_api : 1.0
size :
    rs : 3145728
    jad : 6144
    jar : 1048576

===
--- info
model   : DM004SH
profile : MEXA
heap    :
    base : 4194304
    ex   : 0
location_api : ''
midp : 2.0
cldc : 1.1
limit : 4194304
felica_api : 2.0
size :
    rs : 3145728
    jad : 6144
    jar : 1048576

===
--- info
model   : V604T
profile : JSCL 1.3.2
heap    :
    base : 5242880
    ex   : 0 
location_api : ''
midp : 1.0
cldc : 1.0
limit : 262144
felica_api : ''
size :
    rs : 204800
    jad : 3072
    jar : 204800

===
--- info
model   : V601SH
profile : JSCL 1.2.1
heap    :
    base : 1258496
    ex   : 0
location_api : ''
midp : 1.0
cldc : 1.0
limit : 262144
felica_api : ''
size :
    rs : 204800
    jad : 3072
    jar : 204800

===
--- info
model   : V601N
profile : JSCL 1.1.1
heap    :
    base : 786432
    ex   : 0
location_api : ''
midp : 1.0
cldc : 1.0
limit : 102400
felica_api : ''
size :
    rs : 51200
    jad : 3072
    jar : 81920

===
--- info
model   : V403SH
profile : JSCL 1.0.1
heap    :
    base : 524288
    ex   : 0
location_api : ''
midp : 1.0
cldc : 1.0
limit : 51200
felica_api : ''
size :
    rs : 51200
    jad : 3072
    jar : 51200

===
--- info
model   : V401SA
profile : ''
heap    :
    base : 0
    ex   : 0
location_api : ''
midp : ''
cldc : ''
limit : ''
felica_api : ''
size :
    rs : 0
    jad : 0
    jar : 0


