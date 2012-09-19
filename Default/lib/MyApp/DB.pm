package MyApp::DB;
use 5.10.1;
use strict;
use warnings;
use parent 'Teng';
use Exporter 'import';
use MyApp::Config;

our @EXPORT = qw(database);

sub database {
    state $database = MyApp::DB->new(%{config->param('MyApp::DB')});
}

1;
