package WWW::MobileCarrierJP::DoCoMo::Java;
use WWW::MobileCarrierJP::Declare;
use charnames ':full';
use URI;

my $url = 'http://www.nttdocomo.co.jp/service/imode/make/content/spec/iappli/index.html';

sub scrape {
    my @result;
    my $profile;
    scraper {
        process '//tr[@class="acenter"]', 'models[]', sub {
            my $tree = $_->clone;
            $_->delete for $tree->findnodes('//td[@class="brownLight acenter middle"]');
            $_->delete for $tree->findnodes('//a');

            my $position = 1;
            if (my $new_profile = $tree->findvalue('//td[@rowspan]')) {
                # 余分な文字列削除
                $new_profile =~ s/プロファイル//;
                $profile = $new_profile;
                $position++;
            }

            if ($profile) {
                my $model = $tree->findvalue('//td[position()='.$position.']');
                $model =~ s/\N{GREEK SMALL LETTER MU}/myu/;
                $model =~ s/\（.+）//;
                $model = uc($model);
                push @result, {
                    model   => $model,
                    profile => $profile,
                };
            }
        };
    }->scrape(URI->new($url));

    \@result;
};

1;
__END__

=head1 NAME

WWW::MobileCarrierJP::DoCoMo::Java - get iappli informtation from DoCoMo site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::DoCoMo::Java;
    WWW::MobileCarrierJP::DoCoMo::Java->scrape();

=head1 AUTHOR

Seiji Harada < liptontea2k gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>,
L<http://www.nttdocomo.co.jp/english/service/imode/make/content/spec/iappli/index.html>

