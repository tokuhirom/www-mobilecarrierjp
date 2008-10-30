use strict;
use warnings;
use Test::Base;
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
flashlite  : 2.0
sappli     : 1
gps_basic  : 1
gps_agps   : 0
felica     : 1
pc_browser : 1
mobile_widget: 0

===
--- info
model      : 820SC
flashlite  : 2.0
sappli     : 1
gps_basic  : 0
gps_agps   : 0
felica     : 0
pc_browser : 1
mobile_widget: 0

===
--- info
model      : 706SC
flashlite  : ~
sappli     : 1
gps_basic  : 0
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : 702MO
flashlite  : ~
sappli     : 1
gps_basic  : 0
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : 804NK
flashlite  : ~
sappli     : 1
gps_basic  : 0
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : 703SH
flashlite  : 1.1
sappli     : 1
gps_basic  : 1
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : V604T
flashlite  : ~
sappli     : 1
gps_basic  : 1
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : V601SH
flashlite  : ~
sappli     : 1
gps_basic  : 1
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : V601N
flashlite  : ~
sappli     : 1
gps_basic  : 1
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : V403SH
flashlite  : ~
sappli     : 1
gps_basic  : 1
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : J-SH07
flashlite  : ~
sappli     : 1
gps_basic  : 1
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : 304T
flashlite  : ~
sappli     : 0
gps_basic  : 1
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0

===
--- info
model      : J-SH02
flashlite  : ~
sappli     : 0
gps_basic  : 0
gps_agps   : 0
felica     : 0
pc_browser : 0
mobile_widget: 0


