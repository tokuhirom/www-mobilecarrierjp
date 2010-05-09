use inc::Module::Install;
name 'WWW-MobileCarrierJP';
all_from 'lib/WWW/MobileCarrierJP.pm';

requires 'Web::Scraper'  => '0.24';
requires 'Exporter' => '0.60';
requires 'HTML::Selector::XPath' => '0.03';
requires 'HTML::TableExtract';
requires 'LWP::UserAgent' => '5.834';
requires 'URI';

features(
    'ezweb pictgram scraper' => [
        -default => 1,
        recommends('CAM::PDF', 0),
    ],
    'fast parser' => [
        -default => 0,
        recommends('HTML::TreeBuilder::LibXML', 0.11),
    ],
);

auto_set_repository();

tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'LWP::Online';
build_requires 'Test::More';
use_test_base;

install_script('tools/www-mobilecarrierjp-dump_all.pl');

auto_include;
WriteAll;
