package MyApp::Model;
use strict;
use warnings;
use Data::Validator;
use MyApp::Exception;

sub new {
    my $class = shift;
    my %args  = @_ == 1 ? %{@_} : @_;

    bless \%args, $class;
}

sub validator {
    my $class = shift;
    Data::Validator->new(@_)->with('NoThrow');
}

sub validate {
    my $class = shift;
    my $rule  = shift;

    my $args = $rule->validate(@_);
    if ($rule->has_errors) {
        my $errors = $rule->clear_errors;
        MyApp::Exception->throw(
            code    => 400,
            message => $errors->[0]->{message},
        );
    }

    return $args;
}


1;
