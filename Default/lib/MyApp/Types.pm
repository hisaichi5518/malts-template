package MyApp::Types;
use strict;
use warnings;
use utf8;
use Mouse::Util::TypeConstraints;

subtype 'PositiveInt'
    => as 'Int'
    => where { $_ > 0 };

subtype 'UserId'
    => as 'PositiveInt';

1;
