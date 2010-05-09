use strict;
use Test::More tests => 1;

BEGIN { use_ok 'WWW::MobileCarrierJP' }

eval "use XML::LibXML;";
eval "use HTML::TreeBuilder::LibXML;";
diag "XML::LibXML: " . $XML::LibXML::VERSION || "none";
diag "libxml: " . eval { XML::LibXML::LIBXML_DOTTED_VERSION() } || "none";
diag "HTML::TreeBuilder::LibXML: " . $HTML::TreeBuilder::LibXML::VERSION || "none";

