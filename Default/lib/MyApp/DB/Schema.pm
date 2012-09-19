package MyApp::DB::Schema;
use strict;
use warnings;
use Teng::Schema::Declare;

table {
    name 'users';
    pk 'id';
    columns qw(name);
};

1;
