use strict;
use warnings;
use utf8;
use Test::Base;
use UNIVERSAL::require;

eval "use CAM::PDF; 1;"; ## no critic.
if ($@) {
    plan skip_all => 'CAM::PDF required for testing pictogram info scraper';
} else {
    plan tests => 3*blocks;
}

filters {
    expected => 'yaml',
};

run {
    my $block = shift;

    my $class = "WWW::MobileCarrierJP::@{[ $block->input ]}::PictogramInfo";
    $class->use or die $@;
    my $dat = $class->scrape;

    is ref($dat), 'ARRAY', $block->input;
    cmp_ok scalar(@$dat), '>', 100;
    is_deeply $dat->[0], $block->expected;
};

__END__

===
--- input: EZWeb
--- expected
email_jis: 753A
email_sjis: EB59
name: ！
number: 1
sjis: F659
unicode: E481

===
--- input: DoCoMo
--- expected
en_color: Red
en_name: Fine
jp_color: 赤
jp_name: 晴れ
sjis: F89F
unicode: E63E

===
--- input: ThirdForce
--- expected
unicode: E001
sjis: 1b2447210f

