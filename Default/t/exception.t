use strict;
use warnings;
use utf8;
use Test::More;
use MyApp::Exception;

subtest 'throw' => sub {
    eval {
        MyApp::Exception->throw(
            code    => 500,
            message => 'KUSO',
        );
    };
    my $error = $@;
    is $error->code, 500;
    is $error->message, 'KUSO';
    ok $error->file;
    ok $error->line;
    ok $error->type, 'status.500';
};

subtest 'to_string' => sub {
    eval {
        MyApp::Exception->throw(
            code    => 500,
            message => 'KUSO',
        );
    };
    ok $@;
    like $@, qr/KUSO/;
};

done_testing;
