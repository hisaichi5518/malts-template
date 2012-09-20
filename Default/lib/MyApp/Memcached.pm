package MyApp::Memcached;
use 5.10.1;
use strict;
use warnings;
use Cache::Memcached::IronPlate;
use Cache::Memcached::Fast;
use MyApp::Config;
use MyApp::Exception;
use Carp ();

sub connect {
    my ($class, %args) = @_;
    my $type = $args{type} or Carp::croak("Can't find type.");

    my $config = config->param('MyApp::Memcached')->{$type};
    if (!$config) {
        Carp::croak("Can't find MyApp::Memcached config. type is $type.");
    }

    Cache::Memcached::IronPlate->new(
        cache => Cache::Memcached::Fast->new($config->{'Cache::Memcached::Fast'}),
        %{$config->{'Cache::Memcached::IronPlate'} || {}},
    );
}

sub session {
    my ($class) = @_;

    state $mem = $class->connect(type => 'session');
}

sub cache {
    my ($class) = @_;

    state $mem = $class->connect(type => 'cache');
}

1;
