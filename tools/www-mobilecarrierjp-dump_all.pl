#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use File::Spec;
use lib File::Spec->catfile($FindBin::Bin, '..', 'lib');
use Module::Pluggable::Object; # TODO: switch to Module::Find
use Getopt::Long;
use autodie;
use File::Path qw/mkpath/;
use IO::Handle;
use Pod::Usage;

my $format = 'YAML';
my $datdir = File::Spec->catfile($FindBin::Bin, '..', 'dat');
GetOptions(
    'format=s' => \$format,
    'datdir=s' => \$datdir,
) or pod2usage();
mkpath $datdir;
my $dumper = do {
    if ($format eq 'YAML') {
        require YAML;
        sub { YAML::Dump(@_) }
    } elsif ($format eq 'JSON') {
        require JSON;
        sub { JSON::encode_json(@_) }
    } else {
        print "Unknown format: $format";
        pod2usage();
    }
};

my $pluggable = Module::Pluggable::Object->new(
    'require' => 'yes',
    'search_path' => ['WWW::MobileCarrierJP'],
);

for my $module ($pluggable->plugins()) {
    next if $module eq 'WWW::MobileCarrierJP::Declare';

    print "processing $module\n";

    my $fname = $module;
    $fname =~ s/^WWW::MobileCarrierJP:://;
    $fname =~ s/::/-/g;
    $fname = lc $fname;

    my $ofname = File::Spec->catfile($datdir, "$fname." . lc($format));
    open my $fh, '>:utf8', $ofname;
    print { $fh } $dumper->($module->scrape());
}

__END__

=head1 SYNOPSIS

    % www-mobilecarrierjp-dump_all.pl --format=JSON --datdir=/path/to/output

