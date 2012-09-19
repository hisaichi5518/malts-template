use strict;
use warnings;
use utf8;
use Test::More;
use MyApp::Exception;

MyApp::Exception->throw(
    code    => 500,
    message => 'KUSO',
);

done_testing;
