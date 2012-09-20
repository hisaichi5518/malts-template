package MyApp::Web::Controller::Root;
use strict;
use warnings;
use utf8;
use MyApp::Exception;
use MyApp::Logger;

sub index {
    my ($self, $c) = @_;
    MyApp::Logger->post('test' => {message => 'テストだよ！'});

    $c->render(200, 'root/index.tx');
}

1;
