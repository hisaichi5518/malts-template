{
    'MyApp::DB' => {
        connect_info => [
            'dbi:mysql:host=127.0.0.1;port=3306;database=test', 'root', '', {
                on_connect_do     => ['SET NAMES utf8'],
                mysql_enable_utf8 => 1,
            },
        ],
    },
};
