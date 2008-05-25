use inc::Module::Install;
name 'WWW-MobileCarrierJP';
all_from 'lib/WWW/MobileCarrierJP.pm';

requires 'Web::Scraper' => '0.24';
requires 'Exporter'     => '5.58';
requires 'HTML::Selector::XPath' => '0.03';

features(
    'ezweb pictgram scraper' => [
        -default => 1,
        recommends('CAM::PDF', 0),
    ],
);

build_requires 'Test::More';
use_test_base;

install_script('tools/www-mobilecarrierjp-dump_all.pl');

auto_include;
WriteAll;
