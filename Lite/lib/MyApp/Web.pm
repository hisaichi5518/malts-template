package MyApp::Web;
use 5.10.1;
use strict;
use warnings;
use parent 'Malts';

use Text::Xslate;

sub view {
    my $self = shift;
    state $view = Text::Xslate->new(
        path => [File::Spec->catdir($self->app->base_dir, 'templates')],
    );
}


1;
