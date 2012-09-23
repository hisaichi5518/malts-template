{
    'MyApp::DB' => {
        connect_info => [
            'dbi:mysql:host=127.0.0.1;port=3306;database=test', 'root', '', {
                on_connect_do     => ['SET NAMES utf8'],
                mysql_enable_utf8 => 1,
            },
        ],
    },
    'MyApp::Memcached' => {
        session => {
            'Cache::Memcached::Fast' => {
                servers   => ['127.0.0.1:11211'],
                namespace => 'session:',
            },
        },
        cache => {
            'Cache::Memcached::Fast' => {
                servers   => ['127.0.0.1:11211'],
                namespace => 'cache:',
            },
        },
    },
    'Fluent::Logger' => { # この設定がなければMyApp::Logger::Stderrが使われる
        host => 'localhost',
        port => 24224,
        tag_prefix => 'myapp',# TODO
    },

};
