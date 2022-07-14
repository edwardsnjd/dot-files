#!/usr/bin/perl -w

# https://www.perlmonks.org/?node_id=299012

# Fools a process into thinking that STDOUT is a terminal,
# when in fact it may be a file or a pipe.
use IO::Pty;
use strict;
die "usage: $0 command [args]\n" unless @ARGV;

my $pty = IO::Pty->new;
my $slave = $pty->slave;
open TTY,"/dev/tty" or die "not connected to a terminal\n";
$pty->clone_winsize_from(\*TTY);
close TTY;

my $pid = fork();
die "bad fork: $!\n" unless defined $pid;
if (!$pid) {
    $slave->close();
    open STDOUT,">&=".$pty->fileno() or die $!;
    exec @ARGV;
}
else {
    $pty->close();
    while (defined (my $line = <$slave>)) {
        print $line;
    }
}
