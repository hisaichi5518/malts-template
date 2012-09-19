use strict;
use warnings;

use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use Plack::Builder;
use MyApp::Web;

builder {
    MyApp::Web->to_app;
};
