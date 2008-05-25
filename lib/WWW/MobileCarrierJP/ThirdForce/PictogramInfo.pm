package WWW::MobileCarrierJP::ThirdForce::PictogramInfo;
use strict;
use warnings;
use WWW::MobileCarrierJP::Declare;

my @urls = map { sprintf 'http://creation.mb.softbank.jp/web/web_pic_%02d.html', $_ } 1..6;

parse_one(
    urls  => \@urls,
    xpath => q{//div[@class='contents']/table[2]/tr[1]/td/table/tr/td/table/tr[count(preceding-sibling::tr)>0]},
    scraper => scraper {
        col 2, unicode => [ 'TEXT', sub { s/\s//g } ];
        col 3, sjis =>    [ 'TEXT', sub { s/\s//g }, sub { unpack "H*", shift } ];
    },
);

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::ThirdForce::PictogramInfo - get PictogramInfo informtation from ThirdForce site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::ThirdForce::PictogramInfo;
    WWW::MobileCarrierJP::ThirdForce::PictogramInfo->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

