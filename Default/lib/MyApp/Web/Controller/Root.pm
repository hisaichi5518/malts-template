package MyApp::Web::Controller::Root;
use strict;
use warnings;
use utf8;

sub index {
    my ($self, $c) = @_;

    $c->render(200, 'root/index.tx');
}

1;
