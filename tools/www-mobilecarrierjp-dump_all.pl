use strict;
use warnings;
use YAML;
use FindBin;
use File::Spec;
use lib File::Spec->catfile($FindBin::Bin, '..', 'lib');
use Module::Pluggable::Fast name => 'components', search => ['WWW::MobileCarrierJP'], require => 'yes';

my $datdir = File::Spec->catfile($FindBin::Bin, '..', 'dat');
mkdir $datdir;
for my $module (components()) {
    next if $module eq 'WWW::MobileCarrierJP::Declare';

    my $fname = $module;
    $fname =~ s/^WWW::MobileCarrierJP:://;
    $fname =~ s/::/-/g;
    $fname = lc $fname;
    YAML::DumpFile(
        File::Spec->catfile($datdir, "$fname.yaml"),
        $module->scrape(),
    );
}

