package MyApp::Web::Dispatcher;
use strict;
use warnings;
use Malts::Web::Router::Simple;

get '/' => 'Root#index';
get '/user/:user_id' => 'User#index';

1;
