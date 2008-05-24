package WWW::MobileCarrierJP::ThirdForce::CIDR;
use strict;
use warnings;
use Web::Scraper;
use URI;

my $url = 'http://creation.mb.softbank.jp/web/web_ip.html';

sub scrape {
    scraper {
        process '//td[@bgcolor="#eeeeee"]/font[@size="2" and @class="j10"]', 'cidr[]', ['TEXT', sub {
                        m{^([0-9.]+)(/[0-9]+)};
                        +{ ip => $1, subnetmask => $2 };
                    }];
    }->scrape(URI->new($url))->{cidr};
}

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::ThirdForce::CIDR - get CIDR informtation from ThirdForce site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::ThirdForce::CIDR;
    WWW::MobileCarrierJP::ThirdForce::CIDR->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

