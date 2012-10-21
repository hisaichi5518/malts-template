use strict;
use warnings;
use utf8;
use Test::More;
use MyApp::Config;
use MyApp::Logger;
use Test::Warn;

subtest 'post to stderr' => sub {
    my $guard = config->local('Fluentd::Logger' => undef);
    warning_like { MyApp::Logger->post('test' => {test => 1}) }
        qr/test: {'test' => 1}/
    ;
};

# TODO: post to fluentd

done_testing;
