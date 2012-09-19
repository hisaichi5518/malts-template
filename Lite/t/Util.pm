package t::Util;
use strict;
use warnings;
use Exporter 'import';

use Carp ();
use Plack::Util ();
use Malts::Test ();
use Test::More;
use File::Spec;
use FIle::Basename qw/basedir/;

our @EXPORT = qw/test_app/;

sub test_app (&) {
    my ($client) = @_;
    Carp::croak("Can't find client.") if !$client;

    Malts::Test::test_app(
        app => Plack::Util::load_psgi(
            File::Spec->catfile(basedir(__FILE__), '..', 'app.psgi')
        ),
        app_name => 'MyApp',
        impl     => 'MockHTTP',
        client   => $client,
    );
}

1;
