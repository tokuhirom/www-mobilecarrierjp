package WWW::MobileCarrierJP::DoCoMo::UserAgent;

use strict;
use LWP::Simple qw();

my $DEBUG = 0;

my $URL = 'http://www.nttdocomo.co.jp/service/imode/make/content/spec/useragent/index.html';

sub scrape {

    my $data = LWP::Simple::get($URL);

    my @ua;
    for my $tr ($data =~ m{(<tr.+?>.+?</tr>)}sg) {

        # XXX: class="acenter middle" が入っているのはシリーズ名。
        # 作業のしやすさのため削除
        $tr =~ s[<td.+?rowspan=.+?/td>][];
        $tr =~ s[<td class="acenter middle">.+?</td>][];

        # XXX: class="brownLight  が入っているのはヘッダ。
        # 作業のしやすさのため削除
        $tr =~ s[<td.+?class="brownLight.+?/td>][];
        $tr =~ s[<td scope="col" class="brownLight acenter middle">.+?</td>][]g;

        my @cols = ($tr =~ m{(<td.+?/td>)}sg);
        next if (scalar @cols <= 1);

        debug (scalar @cols);
        debug ("------------------------------------");
        debug ($tr);
        debug ("------------------------------------");
        for my $col (@cols) {

            # XXX: DoCoMo の文字列があるときは User Agent っぽい。
            if ($col =~ m[DoCoMo] ) {
                $col = (
                    grep {/DoCoMo/}
                    split m[&nbsp;|<br>], $col
                )[0]; # XXX: 複数あるときは一番最初ののがブラウザ
            }

            $col = (split /&nbsp;|<br>/, $col)[0];
            $col =~ s/<.+?>//g;
            $col =~ s/\n|\r//g;
            debug ("-      $col");
        }
        debug ("------------------------------------");

        my $model = uc $cols[0];
        my $user_agent = $cols[1] || $cols[2];

        $model =~ s/&MU;/MYU/;

        push @ua, {model => $model, user_agent => $user_agent};
    }

    return \@ua
}

sub debug {
    my $msg = shift;
    print "$msg\n" if $DEBUG;
}
 
1;
__END__

=head1 NAME

WWW::MobileCarrierJP::DoCoMo::UserAgent - get user agent informtation from DoCoMo site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::DoCoMo::UserAgent;
    WWW::MobileCarrierJP::DoCoMo::UserAgent->scrape();

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>,
L<http://www.nttdocomo.co.jp/service/imode/make/content/spec/useragent/index.html>

