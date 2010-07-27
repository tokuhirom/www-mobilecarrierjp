package WWW::MobileCarrierJP::ThirdForce::Display;
use WWW::MobileCarrierJP::Declare;
use charnames ':full';

use utf8;
use List::Util qw/first/;

parse_one(
    urls    => ['http://creation.mb.softbank.jp/terminal/?lup=y&cat=display'],
    xpath   => q(//tr[@bgcolor="#FFFFFF" and @height="18"]),
    scraper => scraper {
        col 1 => 'model'            => 'TEXT';
        col 2 => 'browser_pixels'   => [ 'TEXT', \&_parse_pixels_table ];
        col 3 => 'browser_letters'  => [ 'TEXT', \&_parse_letters_table ];
        col 4 => 'appli_pixels'     => [ 'TEXT', \&_parse_appli_pixels_table ];
        col 5 => 'appli_letters'    => [ 'TEXT', \&_parse_appli_letters_table ];
        col 6 => 'widget_maximized' => [ 'TEXT', \&_parse_pixels_table ];
        col 7 => 'widget'           => [ 'TEXT', \&_parse_pixels_table ];
        col 8 => 'flash'            => [
            'TEXT',
            sub {
                /(\d+)\s*x\s*(\d+)/ or return undef;
                +{ width => $1, height => $2 };
              }
        ];
    },
);

# [{orientation}]\nwidth x height
sub _parse_pixels_table {
    my $text = shift;
    my @result;
    $text =~ s/\s//g;
    return if ($text eq "\N{MULTIPLICATION SIGN}");
    while ( $text =~ s/\[([^\]])+\](\d+)x(\d+)// ) {
        push @result,
          {
            orientation => $1,
            width       => $2,
            height      => $3,
          };
    }
    \@result;
}

# [{orientation}]\n({size}:{width}x{height}\n)+
sub _parse_letters_table {
    my $text = shift;
    my @result;
    $text =~ s/\s//g;
    while ( $text =~ s/\[([^\]]+)\]((?:(?:[^:\[]+:)?\d+x\d+(?:\([^)]+\))?)+)// ) {
        my $mode  = $1;
        my $table = $2;
        my @fontsize_table;
        while ( $table =~ s/(?:([^:]+):)?(\d+)x(\d+)(?:\(([^)]+)\))?// ) {
            push @fontsize_table,
              {
                size_label => $1,
                cols       => $2,
                rows       => $3,
                extra      => $4,
              };
        }
        push @result,
          {
            orientation => $mode,
            size_table => \@fontsize_table,
          };
    }
    \@result;
}

# [{orientation}]\n({width}x{height}\n)+
sub _parse_appli_pixels_table {
    my $text = shift;
    my @result;
    $text =~ s/\s//g;
    while ( $text =~ s/\[([^\]]+)\]((?:[^\d\[]+\d+x\d+)+)// ) {
        my $mode  = $1;
        my $table = $2;
        my @size_table;
        while ( $table =~ s/(\D+)(\d+)x(\d+)?// ) {
            push @size_table,
              {
                resolution => $1,
                width      => $2,
                height     => $3,
              };
        }
        push @result,
          {
            orientation => $mode,
            size_table => \@size_table,
          };
    }
    \@result;
}

# [{orientation}]\n({cols}x{rows}\n)+
sub _parse_appli_letters_table {
    my $text = shift;
    my @result;
    $text =~ s/\s//g;
    while ( $text =~ s/\[([^\]]+)\]((?:[^\d\[]+\d+x\d+)+)// ) {
        my $mode  = $1;
        my $table = $2;
        my @size_table;
        while ( $table =~ s/(\D+)(\d+)x(\d+)?// ) {
            push @size_table,
              {
                resolution => $1,
                cols       => $2,
                rows       => $3,
              };
        }
        push @result,
          {
            orientation => $mode,
            size_table  => \@size_table,
          };
    }
    \@result;
}

1;

__END__

=head1 NAME

WWW::MobileCarrierJP::ThirdForce::Display -
  get display informtation from ThirdForce site.

=head1 SYNOPSIS

    use WWW::MobileCarrierJP::ThirdForce::Display;
    my $table = WWW::MobileCarrierJP::ThirdForce::Display->scrape();

    my $example = shift @$table;

    my $modelname = $example->{model};

    # Some phones have various screen dimensions
    # which depends on screen orientation or window splitting feature.
    my ($browser_resolution) = List::Util::first @{ $example->{browser_pixels} };
    printf "browser resolution is %d x %d\n",
        $browser_resolution->{width}, $browser_resolution->{height};


=head1 AUTHOR

Yuki Fujisaki <kitakore@gmail.com>

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

