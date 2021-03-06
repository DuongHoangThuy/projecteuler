#!/usr/bin/env perl

# PODNAME: 7.pl
# ABSTRACT: 10001st prime

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-02-03

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $ordinal = 10_001;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

## no critic (ProhibitMagicNumbers)
my @primes = ( 2, 3 );
my $num = 5;
## use critic

while ( scalar @primes < $ordinal ) {
    my $is_prime = 1;
    my $num_sqrt = int sqrt $num;
    foreach my $prime (@primes) {
        last if $prime > $num_sqrt;
        if ( $num % $prime == 0 ) {
            $is_prime = 0;
            last;
        }
    }
    if ($is_prime) {
        push @primes, $num;
    }
    $num += 2;
}

printf "%d\n", $primes[-1];

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'ordinal=i' => \$ordinal,
        'debug'     => \$debug,
        'help'      => \$help,
        'man'       => \$man,
    ) or pod2usage(2);

    # Documentation
    if ($help) {
        pod2usage(1);
    }
    elsif ($man) {
        pod2usage( -verbose => 2 );
    }

    return;
}

__END__
=pod

=encoding UTF-8

=head1 NAME

7.pl

10001st prime

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "10001st prime". The problem is:
What is the 10 001st prime number?

=head1 EXAMPLES

    perl 7.pl --ordinal 6

=head1 USAGE

    7.pl
        [--ordinal INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--ordinal INT>

The ordinal of the required prime.

=item B<--debug>

Print debugging information.

=item B<--help>

Print a brief help message and exit.

=item B<--man>

Print this script's manual page and exit.

=back

=head1 DEPENDENCIES

None

=head1 AUTHOR

=over 4

=item *

Ian Sealy <ian.sealy@sanger.ac.uk>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
