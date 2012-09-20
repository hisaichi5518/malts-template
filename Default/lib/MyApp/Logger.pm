package MyApp::Logger;
use 5.10.1;
use strict;
use warnings;
use Fluent::Logger;
use MyApp::Config;

sub client {
    state $client = Fluent::Logger->new(
        config->param('Fluent::Logger'),
    );
}

sub post {
    my ($class, $type, $msg) = @_;
    Carp::croak('$msg: must be a HashRef.') if ref $msg ne 'HASH';

    my $message = $class->_build_message($msg);

    # TODO: evalしてダメだったら別のファイルに残すとかする
    $class->client->post($type, $message);
}

sub _build_message {
    my ($class, $msg) = @_;

    # TODO: なにかしらする

    return $msg;
}

1;
