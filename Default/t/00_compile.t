use strict;
use warnings;
use utf8;

use Test::More;

BEGIN {
    use_ok qw/
        MyApp
        MyApp::Web
        MyApp::Web::Dispatcher
        MyApp::Web::Controller::Root
    /;
};

done_testing;
