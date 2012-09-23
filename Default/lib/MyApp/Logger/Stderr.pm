package MyApp::Logger::Stderr;
use 5.10.1;
use strict;
use warnings;
use Log::Minimal qw/warnf/;

sub new { bless {}, shift }

sub post {
    my ($self, $tag, $hash) = @_;

    local $Log::Minimal::AUTODUMP = 1;
    warnf "$tag: %s", $hash;
}

1;
