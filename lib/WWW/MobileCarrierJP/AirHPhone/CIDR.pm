package WWW::MobileCarrierJP::AirHPhone::CIDR;
use strict;
use warnings;
use utf8;
use WWW::MobileCarrierJP::Declare qw/get/;

sub url { 'http://www.willcom-inc.com/ja/service/contents_service/create/center_info/index.html' }

sub scrape {
    my $content = get(__PACKAGE__->url);
    my @parts = split /<font size="2" color="#4c4c4c">/, $content;
    my @result;
    my $removed = {};
    for my $part (@parts) {
        my $is_removed;
        if ( $part =~ /削除IPアドレス帯域/ ) {
            $is_removed++;
        }
        while ($part =~ s{([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)(/[0-9]+)}{}) {
            if ( $is_removed ) {
                $removed->{ $1 . "/" . $2 } = 1;
            } else {
                push @result,
                  {
                    ip         => $1,
                    subnetmask => $2,
                  };
            }
        }
    }
    my $unique_of = {};
    my @ret;
    for my $cidr ( @result ) {
        my $rule = $cidr->{ip} . "/" . $cidr->{subnetmask};
        if ( $removed->{$rule} ) {
            next;
        }
        if ( ! $unique_of->{$rule} ) {
            push @ret, $cidr;
        }
        $unique_of->{$rule}++;
    }
    return \@ret;
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::MobileCarrierJP::AirHPhone::CIDR - CIDR(Willcom)

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::AirHPhone::CIDR;
    WWW::MobileCarrierJP::AirHPhone::CIDR->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

