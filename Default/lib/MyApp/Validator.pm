package MyApp::Validator;
use strict;
use warnings;
use Exporter 'import';
use Data::Validator;

our @EXPORT = qw/validator/;

sub validator {
    Data::Validator->new(@_)->with('Method');
}

1;
