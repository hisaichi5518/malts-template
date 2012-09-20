package MyApp::Web::Controller::User;
use strict;
use warnings;
use MyApp::Model::User;

sub index {
    my ($class, $c) = @_;
    my $user_id = $c->args->{user_id};

    my $user = MyApp::Model::User->search_user(user_id => $user_id);
    $c->render(200, 'user/index.tx', {user => $user});

}

1;
