use strict;
use warnings;
BEGIN {
    unshift @INC, 'inc';

    # author requires, or bundled modules
    my @devmods = (
        'inc::Module::Install'         => [1.00],
        'Module::Install::AuthorTests' => [0.002],
        'Malts'                        =>
            [0.05, 'https://github.com/malts/p5-malts/tarball/master'],
    );
    my @not_available;
    while(my($mod, $args) = splice @devmods, 0, 2) {
        my $ver = $args->[0];
        my $uri = $args->[1];
        eval qq{use $mod $ver (); 1} or push @not_available, $uri ? $uri : $mod;
    }
    if(@not_available) {
        print qq{# The following modules are not available.\n};
        print qq{# `perl $0 | cpanm` will install them:\n};
        print $_, "\n" for @not_available;
        exit 1;
     }
}
exit;
use inc::Module::Install;

all_from 'lib/MyApp.pm';

requires 'Config::ENV'     => 0.10;
requires 'Teng'            => 0.15;
requires 'Data::Validator' => 0.09;
requires 'Proclet'         => 0.14;

test_requires 'Test::More'     => 0.96;
test_requires 'Test::Requires' => 0.06;

tests_recursive;
author_tests 'xt';

clean_files qw(
    MyApp-*
    *.stackdump
    cover_db *.gcov *.gcda *.gcno
    nytprof
    *.out
);

# SEE http://blog.64p.org/entry/20110928/1317193393
sub MY::test_via_harness {
        "\tprove -r t"
}
sub MY::top_targets {
        <<"..."
all ::
\t
pure_all ::
\t
subdirs ::
\t
config ::
\t
...
}

WriteAll(check_nmake => 0);
