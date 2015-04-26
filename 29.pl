#!/usr/bin/env perl

# PODNAME: 29.pl
# ABSTRACT: Distinct powers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-04-25

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
## no critic (ProhibitMagicNumbers)
my $max = 100;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @primes = get_primes_up_to($max);

my %term;

foreach my $a ( 2 .. $max ) {
    my @a_factors = get_prime_factors( $a, \@primes );
    foreach my $b ( 2 .. $max ) {
        my @factors;
        foreach my $factor (@a_factors) {
            foreach ( 1 .. $b ) {
                push @factors, $factor;
            }
        }
        $term{ join q{*}, @factors } = 1;
    }
}

printf "%d\n", scalar keys %term;

sub get_primes_up_to {
    my ($limit) = @_;

    my $sieve_bound = int( ( $limit - 1 ) / 2 );    # Last index of sieve
    my @sieve;
    my $cross_limit = int( ( int( sqrt $limit ) - 1 ) / 2 );
    foreach my $i ( 1 .. $cross_limit ) {
        if ( !$sieve[ $i - 1 ] ) {

            # 2 * $i + 1 is prime, so mark multiples
            my $j = 2 * $i * ( $i + 1 );
            while ( $j <= $sieve_bound ) {
                $sieve[ $j - 1 ] = 1;
                $j += 2 * $i + 1;
            }
        }
    }

    my @primes_up_to = (2);
    foreach my $i ( 1 .. $sieve_bound ) {
        if ( !$sieve[ $i - 1 ] ) {
            push @primes_up_to, 2 * $i + 1;
        }
    }

    return @primes_up_to;
}

sub get_prime_factors {
    my ( $number, $primes ) = @_;

    my @factors;

    foreach my $prime ( @{$primes} ) {
        while ( $number % $prime == 0 ) {
            push @factors, $prime;
            $number /= $prime;
        }
    }

    return @factors;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'max=i' => \$max,
        'debug' => \$debug,
        'help'  => \$help,
        'man'   => \$man,
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

29.pl

Distinct powers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Distinct powers". The problem is:
How many distinct terms are in the sequence generated by a^b for 2 ≤ a ≤ 100
and 2 ≤ b ≤ 100?

=head1 EXAMPLES

    perl 29.pl --max 5

=head1 USAGE

    29.pl
        [--max INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--max INT>

The maximum value of a and b.

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
