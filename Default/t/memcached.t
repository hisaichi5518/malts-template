use strict;
use warnings;
use utf8;
use Test::More;
use Test::TCP;
use MyApp::Config;
use MyApp::Memcached;

my $memcached = Test::TCP->new(
    code => sub {
        my $port = shift;

        exec 'memcached', '-p' => $port;
        die "cannot execute memcached: $!";
    },
);

subtest 'connect ' => sub {
    my $guard = config->local('MyApp::Memcached' => {
        session => {
            'Cache::Memcached::Fast' => {
                servers   => ['127.0.0.1:'.$memcached->port],
                namespace => 'session:',
            },
        },
        cache => {
            'Cache::Memcached::Fast' => {
                servers   => ['127.0.0.1:'.$memcached->port],
                namespace => 'cache:',
            },
        },
    });

    isa_ok +MyApp::Memcached->session, 'Cache::Memcached::IronPlate';
    isa_ok +MyApp::Memcached->cache, 'Cache::Memcached::IronPlate';
};

done_testing;
