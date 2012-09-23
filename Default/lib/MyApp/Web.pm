package MyApp::Web;
use 5.10.1;
use strict;
use warnings;
use parent 'Malts';

use Text::Xslate;
use Scalar::Util qw/blessed/;
use MyApp::Config ();
use Malts::Util;
use Encode;

sub view {
    my $self = shift;
    state $view = Text::Xslate->new(
        path => [File::Spec->catdir($self->app->base_dir, 'templates')],
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
                my $is_blessed = blessed $@;
                my $code    = $is_blessed ? $@->code      : 500;
                my $message = $is_blessed ? $@->to_string : $@ || 'Internet Server Error';

                warn $self->encoding->encode($message);
                if (!Malts::Util::DEBUG) {
                    $message = Malts::Util::remove_fileline($message);
                }

                $res = $self->render($code, 'error/index.tx', {
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
