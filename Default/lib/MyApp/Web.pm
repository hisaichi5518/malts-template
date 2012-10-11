package MyApp::Web;
use 5.10.1;
use strict;
use warnings;
use parent 'Malts';

use Text::Xslate;
use Scalar::Util qw/blessed/;
use MyApp::Config ();
use MyApp::Exception;
use MyApp::Logger;
use Malts::Util;
use Encode;

sub view {
    my $self = shift;
    state $view = Text::Xslate->new(
        path   => [File::Spec->catdir($self->app->base_dir, 'templates')],
        module => ['Malts::Web::View::Util'],
    );
}

sub to_app {
    my ($class) = @_;

    return sub {
        my $env  = shift;
        my $self = $class->setup(env => $env);
        local $Malts::_context = $self;

        my $res;
        $self->run_hooks('before_dispatch', \$res);
        if (!$res) {
            $res = eval { $self->dispatch };
            if (!$res || $@) {
                my $error = $@;
                my $is_blessed = blessed $error;

                if (!$error || !$is_blessed) {
                    $error = MyApp::Exception->new(
                        code    => 500,
                        message => $error || 'Internet Server Error',
                    );
                }

                # dieで死んだものをすべてソイヤー！
                MyApp::Logger->post($error->type => {error => $error});

                my $message = $error->message;
                if (!Malts::Util::DEBUG) {
                    $message = Malts::Util::remove_fileline($message);
                }

                $res = $self->render($error->code, 'error/index.tx', {
                    message => $message,
                });
            }
        }

        $self->run_hooks('after_dispatch', \$res);
        return $res->finalize;
    };
}

sub config { MyApp::Config->current }

1;
