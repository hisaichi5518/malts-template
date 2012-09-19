package MyApp::Exception;
use strict;
use warnings;
use overload q[""] => \&to_string, fallback => 1;
use Malts::Util;

sub new {
    my ($class, %args) = @_;
    bless \%args, $class;
}

sub throw {
    my ($class, %args) = @_;

    my ($pkg, $file, $line) = caller(0);
    die $class->new(
        code    => $args{code}    || 500,
        message => $args{message} || 'Died',
        file    => $file,
        line    => $line,
    );
}

sub code    { shift->{code}    }
sub message { shift->{message} }
sub file    { shift->{file}    }
sub line    { shift->{line}    }

sub to_string {
    my ($self) = @_;
    return sprintf "%s at %s line %d.\n", $self->message, $self->file, $self->line;
}

1;
