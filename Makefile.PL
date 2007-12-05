use inc::Module::Install;
name 'WWW-MobileCarrierJP';
all_from 'lib/WWW/MobileCarrierJP.pm';

requires 'Web::Scraper' => 0;

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
