use strict;
use warnings;
use Test::More tests => 6;
use WWW::MobileCarrierJP::ThirdForce::UserAgent;

my $dat = WWW::MobileCarrierJP::ThirdForce::UserAgent->scrape;
ok ref($dat), 'ARRAY';
cmp_ok scalar(@$dat), '>', 30;

{
    my ($m, ) = grep { $_->{model} eq '823T' } @$dat;
    ok $m;
    is $m->{user_agent}, 'SoftBank/1.0/823T/TJ001[/Serial] Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1';
}

ok grep { $_->{model} eq '821P' } @$dat;
is scalar(grep { $_->{model} =~ /series/ } @$dat), 0;

