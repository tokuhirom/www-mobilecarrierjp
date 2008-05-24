package WWW::MobileCarrierJP::ThirdForce::PictogramInfo;
use strict;
use warnings;
use Web::Scraper;
use URI;

my @urls = map { sprintf 'http://creation.mb.softbank.jp/web/web_pic_%02d.html', $_ } 1..6;

sub scrape {
    my $res;

    my $emoji = scraper {
        process q{//div[@class='contents']/table[2]/tr[1]/td/table/tr/td/table/tr[count(preceding-sibling::tr)>0]},
          'emoji[]' => scraper {
            process '//td[2]', unicode => [ 'TEXT', sub { s/\s//g } ];
            process '//td[3]',
              sjis => [ 'TEXT', sub { s/\s//g }, sub { unpack "H*", shift } ];
          };
        result 'emoji';
    };

    foreach my $url (@urls) {
        push @$res, @{ $emoji->scrape( URI->new($url) ) };
    }

    $res;
}

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

