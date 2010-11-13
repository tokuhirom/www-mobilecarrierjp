package WWW::MobileCarrierJP::DoCoMo::CIDR;
use strict;
use warnings;
use utf8;
use Web::Scraper;
use URI;
use WWW::MobileCarrierJP::Declare;

sub url { 'http://www.nttdocomo.co.jp/service/imode/make/content/ip/'; }

sub scrape {
    my $content = get(url());
    if ($content =~ m{\Q<h3 class="title">WEBアクセス時 （iモードブラウザ）</h3>\E(.+)\Q<h3 class="title">WEBアクセス時（フルブラウザ）</h3>\E}s) {
        my $body = $1;
        my @ret;
        while ($body =~ s!<li>([0-9.]+)/([0-9]+).*</li>!!) {
            push @ret, +{ ip => $1, subnetmask => $2 };
        }
        return \@ret;
    } else {
        die "cannot parse the html: " . url();
    }
}

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::DoCoMo::CIDR - get CIDR informtation from DoCoMo site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::DoCoMo::CIDR;
    WWW::MobileCarrierJP::DoCoMo::CIDR->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

