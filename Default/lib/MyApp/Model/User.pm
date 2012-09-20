package MyApp::Model::User;
use 5.10.1;
use strict;
use warnings;
use utf8;
use parent 'MyApp::Model';

use MyApp::DB;
use MyApp::Exception;

sub search_user {
    my $self = shift;

    state $rule = $self->validator(
        user_id => {isa => 'Num'},
    );

    my $args = $self->validate($rule, @_);
    my $user_id = $args->{user_id};


    my $user = database->single('users', {id => $user_id});
    if (!$user) {
        MyApp::Exception->throw(code => 404, message => 'ユーザーが存在していません');
    }

    return $user;
}

1;
