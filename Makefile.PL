use inc::Module::Install;
name 'WWW-MobileCarrierJP';
all_from 'lib/WWW/MobileCarrierJP.pm';

requires 'Web::Scraper'  => '0.24';
requires 'Exporter' => '0.60';
requires 'HTML::Selector::XPath' => '0.03';
requires 'HTML::TableExtract';

features(
    'ezweb pictgram scraper' => [
        -default => 1,
        recommends('CAM::PDF', 0),
    ],
);

auto_set_repository;

tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
build_requires 'Test::More';
use_test_base;

install_script('tools/www-mobilecarrierjp-dump_all.pl');

auto_include;
WriteAll;
