package MyApp::Config;
use strict;
use warnings;
use Config::ENV 'PLACK_ENV', export => 'config';

common load('config/common.pl');

1;
