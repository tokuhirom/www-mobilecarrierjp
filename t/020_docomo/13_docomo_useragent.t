use strict;
use warnings;
use Test::More tests => 10;
use WWW::MobileCarrierJP::DoCoMo::UserAgent;

my $dat = WWW::MobileCarrierJP::DoCoMo::UserAgent->scrape;
is ref($dat), 'ARRAY';
cmp_ok scalar(@$dat), '>', 30;

is join(',', sort(keys %{$dat->[0]})), 'model,user_agent';

{
    my ($m, ) = grep { $_->{model} eq 'F-09A' } @$dat;
    ok $m, 'F-09A';
    is $m->{user_agent}, 'DoCoMo/2.0 F09A3(c500;TB;W24H16)';
}

ok grep { $_->{model} eq 'P704Imyu' } @$dat;
is scalar(grep { $_->{model} =~ /&mu;/i } @$dat), 0;

# iモード対応HTML2.0（mova 502iなど）は、表示が変なので、注意ぶかくチェックする
ok grep { $_->{user_agent} eq 'DoCoMo/1.0/P651ps' } @$dat;
ok grep { $_->{user_agent} eq 'DoCoMo/1.0/R691i' } @$dat;
ok grep { $_->{user_agent} eq 'DoCoMo/1.0/F210i/c10' } @$dat;

