use strict;
use warnings;
use Test::More tests => 14;
use WWW::MobileCarrierJP::DoCoMo::HTMLVersion;

my $vermap = WWW::MobileCarrierJP::DoCoMo::HTMLVersion->scrape;
is ref($vermap), 'ARRAY', 'this API returns arrayref';
cmp_ok scalar(@$vermap), '>', 4, 'docomo has many html versions';
cmp_ok scalar(grep !/^\d\.\d/, map { $_->{version} } @$vermap), '==', 0, 'all keys are version number';
cmp_ok scalar(grep !/[a-zA-Z0-9]+/, map { @{$_->{models}} } @$vermap), '==', 0;

for my $version (qw/1.0 2.0 3.0 4.0 5.0 6.0 7.0 7.1/) {
    ok scalar(grep { $_->{version} eq $version } @$vermap), "$version exists in the data.";
}

is_deeply map({ $_->{models} } grep { $_->{version} eq '1.0' } @$vermap), [qw/D501i F501i N501i P501i/], "CHECK 1.0";
is_deeply map({ $_->{models} } grep { $_->{version} eq '6.0' } @$vermap), [
    qw/
        F902i D902i N902i P902i SH902i SO902i SH902iS P902iS N902iS D902iS
        F902iS SO902iWP+ SH902iSL N902iX N902iL P702i N702iD F702iD SH702iD
        D702i SO702i D702iBCL SA702i SH702iS N702iS P702iD D702iF D851iWM
        F882iES N601i D800iDS P703imyu F883i P704imyu L704i L705i L705iX
      /
], "CHECK 6.0";

