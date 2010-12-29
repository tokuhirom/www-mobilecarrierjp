use strict;
use warnings;
use Test::Base;
use LWP::Online ":skip_all";
use WWW::MobileCarrierJP::ThirdForce::Service;

plan tests => 1 + 2*blocks;

my $res;
if ($ENV{YAML}) {
    require YAML;
    $res = YAML::LoadFile($ENV{YAML});
} else {
    $res = WWW::MobileCarrierJP::ThirdForce::Service->scrape();
}

cmp_ok scalar(@$res), '>', 100, 'thirdforce has many phones';

filters { info => [qw/yaml/] };
run {
    my $block = shift;
    check($block->info);
};

sub check {
    my ($info, ) = @_;
    my ($model, ) = grep { $_->{model} eq $info->{model} } @$res;
    ok $model, "got a $info->{model} phone info";
    is_deeply $model => $info, "check the $info->{model}";
}

#   do {
#       my $disney_mobile = grep { $_->{model} eq 'DM001SH' } @$res;
#       ok $disney_mobile, "got a disney mobile phone's info";
#   #  is_deeply {felica => 1, 
#   #  - felica: 0
#   #  flashlite: 2.0
#   #  gps_agps: 0
#   #  gps_basic: 0
#   #  model: 820SC
#   #  pc_browser: 1
#   #  sappli: 1
#   };


__END__

===
--- info
model      : DM001SH
sappli     : 1
gps_basic  : 1
gps_agps   : 0
felica     : 1
pc_browser : 1
mobile_widget: 0

===
--- info
model      : 820SC
sappli     : 1
gps_basic  : 0
gps_agps   : 0
felica     : 0
pc_browser : 1
mobile_widget: 0

===
--- info
model      : 706SC
sappli     : 1
gps_basic  : 0
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : 702MO
sappli     : 1
gps_basic  : 0
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : 804NK
sappli     : 1
gps_basic  : 0
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : 703SH
sappli     : 1
gps_basic  : 1
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0


