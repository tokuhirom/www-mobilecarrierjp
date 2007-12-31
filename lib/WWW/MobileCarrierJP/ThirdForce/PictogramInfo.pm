package WWW::MobileCarrierJP::ThirdForce::PictogramInfo;
use strict;
use warnings;
use Web::Scraper;
use URI;

my @urls = map "http://developers.softbankmobile.co.jp/dp/tool_dl/web/picword_0$_.php", 1..6;

sub scrape {
    my $res;

    my $emoji = scraper {
        process '//table[@width="100%" and @cellpadding="2"]//tr/td/font/../..',
            'emoji[]' => scraper {
            process '//td[2]/font', unicode => 'TEXT';
            process '//td[3]/font', sjis => [ 'TEXT', sub { unpack "H*", shift } ];
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

