use strict;
use warnings;

use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'extlib', 'lib', 'perl5');
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use Plack::Builder;

use MyApp::Web;
use MyApp::Config;
use Plack::Session::Store::Cache;
use MyApp::Memcached;

builder {
    enable 'ReverseProxy';
    enable 'Session',
        store => Plack::Session::Store::Cache->new(
            cache => MyApp::Memcached->session,
        );

    MyApp::Web->to_app;
};
