use strict;
use warnings;
use Test::Base;
use WWW::MobileCarrierJP::DoCoMo::Java;

plan tests => 2 + 2 * blocks;

my $dat = WWW::MobileCarrierJP::DoCoMo::Java->scrape;
is ref($dat), 'ARRAY';
is join(',', sort(keys %{$dat->[0]})), 'model,profile';

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
model   : F-01A
profile : Star-1.0

===
--- info
model   : N-04A
profile : Star-1.0

===
--- info
model   : P-07A
profile : Star-1.1

===
--- info
model   : N-03B
profile : Star-1.1

===
--- info
model   : SH-01B
profile : Star-1.2

===
--- info
model   : N-02B
profile : Star-1.2

===
--- info
model   : F503I
profile : DoJa-1.0

===
--- info
model   : SO503IS
profile : DoJa-1.0

===
--- info
model   : NM850IG
profile : DoJa-1.5OE

===
--- info
model   : N600I
profile : DoJa-1.5OE

===
--- info
model   : D504I
profile : DoJa-2.0

===
--- info
model   : F504IS
profile : DoJa-2.0

===
--- info
model   : FOMA F2051
profile : DoJa-2.1

===
--- info
model   : FOMA N2701
profile : DoJa-2.1

===
--- info
model   : FOMA F2102V
profile : DoJa-2.2

===
--- info
model   : FOMA N2102V
profile : DoJa-2.2

===
--- info
model   : L600I
profile : DoJa-2.5OE

===
--- info
model   : NM706I
profile : DoJa-2.5OE

===
--- info
model   : D505I
profile : DoJa-3.0

===
--- info
model   : P506IC
profile : DoJa-3.0

===
--- info
model   : F900I
profile : DoJa-3.5

===
--- info
model   : N900IG
profile : DoJa-3.5

===
--- info
model   : L704I
profile : DoJa-3.5LE

===
--- info
model   : L-03A
profile : DoJa-3.5LE

===
--- info
model   : SH901IC
profile : DoJa-4.0

===
--- info
model   : P901ITV
profile : DoJa-4.0

===
--- info
model   : F700I
profile : DoJa-4.0LE

===
--- info
model   : M702IG
profile : DoJa-4.0LE

===
--- info
model   : F902I
profile : DoJa-4.1

===
--- info
model   : N902IX
profile : DoJa-4.1

===
--- info
model   : P702I
profile : DoJa-4.1LE

===
--- info
model   : L-01A
profile : DoJa-4.1LE

===
--- info
model   : SH903I
profile : DoJa-5.0

===
--- info
model   : SH706IE
profile : DoJa-5.0

===
--- info
model   : N703ID
profile : DoJa-5.0LE

===
--- info
model   : F-05A
profile : DoJa-5.0LE

===
--- info
model   : SH905I
profile : DoJa-5.1

===
--- info
model   : P-03B
profile : DoJa-5.1

===
--- info
model   : P705I
profile : DoJa-5.1LE

===
--- info
model   : L-02B
profile : DoJa-5.1LE

