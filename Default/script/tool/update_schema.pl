use 5.10.1;
use strict;
use warnings;

use File::Spec;
use File::Basename;
use lib File::Spec->catdir('./extlib', 'lib', 'perl5');
use lib File::Spec->catdir('./lib');

use IO::Prompt::Simple qw(prompt);
use MyApp::Config;

my $SQL_DIR      = File::Spec->catdir('./sql');
my $SQL_FILE     = File::Spec->catfile($SQL_DIR, 'schema.sql');
my $connect_info = connect_info();

main();

sub main {
    if (prompt("update the $SQL_FILE?", 'n') eq 'y') {
        mkdir $SQL_DIR if !-d $SQL_DIR;

        open my $fh, '>', $SQL_FILE or die "$SQL_FILE:$!";
        print $fh dump_sql($connect_info);
        close $fh;

        say "updated the sql file. => $SQL_FILE";
    }
    else {
        say "not updated the sql file.";
    }
}

sub dump_sql {
    my ($connect_info) = @_;

    my $sql = run_command(
        'mysqldump', '--opt',
        '-d' => $connect_info->{database},
        '-P' => $connect_info->{port},
        '-u' => $connect_info->{user},
        $connect_info->{password} ? ('-p' => $connect_info->{password}): (),
    );

    return remove_sql_garbages($sql);
}

sub connect_info {
    my $connect_info = config->param('MyApp::DB')->{connect_info};
    my %config       = map { split '=', $_ } ((split ';', (split ':', $connect_info->[0])[2]));

    return {
        user     => $connect_info->[1],
        password => $connect_info->[2],
        %config,
    };
}

sub run_command {
    my (@commands) = @_;
    `@commands`;
}

sub remove_sql_garbages {
    my $data = join "", @_;

    $data =~ s{^/\*.*\*/;$}{}gm;        # コメント
    $data =~ s{^--.*$}{}gm;             # コメント
    $data =~ s{^\n$}{}gm;               # 改行のみの行
    $data =~ s{ AUTO_INCREMENT=\d+}{}g; # AUTO_INCREMENT
    return $data;
}
