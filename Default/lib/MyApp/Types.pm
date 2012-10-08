package MyApp::Types;
use strict;
use warnings;
use Mouse::Util::TypeConstraints;

subtype 'UserId' => as 'Int' => where { $_ > 0 };

1;
