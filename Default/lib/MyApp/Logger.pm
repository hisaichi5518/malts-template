package MyApp::Logger;
use 5.10.1;
use strict;
use warnings;
use Fluent::Logger;
use MyApp::Logger::Stderr;
use MyApp::Config;

sub client {
    state $client = do {
        if (my $config = config->param('Fluent::Logger')) {
            Fluent::Logger->new($config);
        }
        else {
            MyApp::Logger::Stderr->new;
        }
    };
}

sub post {
    my ($class, $type, $msg) = @_;
    Carp::croak('$msg: must be a HashRef.') if ref $msg ne 'HASH';

    my $message = $class->_build_message($msg);
    $class->client->post($type, $message);
}

sub _build_message {
    my ($class, $msg) = @_;

    for my $name (keys %$msg) {
        my $v = $msg->{$name};

        if (ref($v) =~ m/^MyApp::DB::Row/gm) {
            $msg->{$name} = $v->get_columns();
        }
        elsif (ref($v) =~ m/^MyApp::Exception/gm) {
            $msg->{$name} = {
                code    => $v->code,
                message => $v->to_string,
            };
        }
    }

    return $msg;
}

1;
