use inc::Module::Install;
name 'WWW-MobileCarrierJP';
all_from 'lib/WWW/MobileCarrierJP.pm';

requires 'Web::Scraper'  => '0.24';
requires 'Exporter' => '0.60';
requires 'HTML::Selector::XPath' => '0.03';
requires 'HTML::TableExtract' => 2.10;
requires 'LWP::UserAgent' => '5.834';
requires 'URI';

features(
    'ezweb pictgram scraper' => [
        -default => 1,
        recommends('CAM::PDF', 0),
    ],
    'fast parser' => [
        -default => 0,
        recommends('HTML::TreeBuilder::LibXML', 0.12),
    ],
);

auto_set_repository();

tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'LWP::Online' => 1.07;
test_requires 'Test::More' => 0.96;
use_test_base;

install_script('tools/www-mobilecarrierjp-dump_all.pl');

WriteAll;
