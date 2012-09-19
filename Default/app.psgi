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
use Cache::Memcached::Fast;
use Cache::Memcached::IronPlate;


my $public_dir = File::Spec->catdir(dirname(__FILE__), 'public');
builder {
    my $mem = Cache::Memcached::IronPlate->new(
        cache => Cache::Memcached::Fast->new({
            servers => config->param('memcached_servers') || [],
        }),
    );

    enable 'Plack::Middleware::Static',
        path => qr{^/(?:images|js|css|swf)/},
        root => $public_dir;

    enable 'Plack::Middleware::Static',
        path => qr{^/(?:robots\.txt|favicon\.ico)$},
        root => $public_dir;

    enable 'Plack::Middleware::ReverseProxy';

    enable 'Plack::Middleware::Session',
        store => Plack::Session::Store::Cache->new(cache => $mem);

    MyApp::Web->to_app;
};
