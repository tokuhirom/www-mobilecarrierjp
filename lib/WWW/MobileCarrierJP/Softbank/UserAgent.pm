package WWW::MobileCarrierJP::Softbank::UserAgent;
use WWW::MobileCarrierJP::Declare;

parse_one( 
    urls => ['http://creation.mb.softbank.jp/terminal/index.html'],
    xpath => q(//tr[@bgcolor="#FFFFFF"]/td[@rowspan="5"]/..),
    scraper => scraper {
        col 1 => 'model'      => 'TEXT';
        col 2 => 'user_agent' => ['TEXT', sub { s/\s+$//; }];
    },
);

1;
__END__

=encoding utf-8

=head1 NAME

WWW::MobileCarrierJP::Softbank::UserAgent - get UserAgent informtation from Softbank site(OBSOLETE)

=head1 SYNOPSIS

    (OBSOLETE)

=head1 DESCRIPTION

THIS MODULE IS OBSOLETE.

YOU SHOULD USE Softbank::HTTPHeader & Softbank::Service.

This module is no longer supported.

You should also strongly avoid the use of this module.

=head1 AUTHOR

Tokuhiro Matsuno < tokuhirom gmail com >

=head1 SEE ALSO

L<WWW::MobileCarrierJP>

