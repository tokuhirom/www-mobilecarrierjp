use strict;
use warnings;
use Test::More tests => 8;
use WWW::MobileCarrierJP::DoCoMo::HTMLVersion;

my $vermap = WWW::MobileCarrierJP::DoCoMo::HTMLVersion->scrape;
is ref($vermap), 'ARRAY', 'this API returns arrayref';
cmp_ok scalar(@$vermap), '>', 4, 'docomo has many html versions';
cmp_ok scalar(grep !/^\d\.\d/, map { $_->{version} } @$vermap), '==', 0, 'all keys are version number';
cmp_ok scalar(grep !/[a-zA-Z0-9]+/, map { @{$_->{models}} } @$vermap), '==', 0;

ok scalar(grep { $_->{version} eq '1.0' } @$vermap), 'exists 1.0';
ok scalar(grep { $_->{version} eq '7.1' } @$vermap), 'exists 7.1';

is_deeply map({ $_->{models} } grep { $_->{version} eq '1.0' } @$vermap), [qw/D501i F501i N501i P501i/];
is_deeply map({ $_->{models} } grep { $_->{version} eq '7.0' } @$vermap), [
    qw/
      SH903i P903i N903i D903i F903i SO903i D903iTV F903iX P903iTV SH903iTV F903iBSC P903iX SO903iTV
      N703iD F703i P703i D703i SH703i N703imyu SO703i
      SH904i N904i F904i D904i P904i
      SO704i F704i N704imyu SH704i D704i P704i
      F883iES F801i
      /
];

