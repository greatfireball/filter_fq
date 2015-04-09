#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;

my $len = 100;
my $max_reads = 25000000;

my $reads = undef;
my $mates = undef;

my $num_pairs = 0;

GetOptions(
    'len=i' => \$len,
    'max_reads=i' => \$max_reads,
    'reads=s' => \$reads,
    'mates=s' => \$mates,
    );

open(READS, "<", $reads) || die;
open(MATES, "<", $mates) || die;

while (!(eof(READS) || eof(MATES)))
{
    my @input = (scalar <READS>, scalar <READS>, scalar <READS>, scalar <READS>, scalar <MATES>, scalar <MATES>, scalar <MATES>, scalar <MATES>);

    my @seq = @input[(1, 5)];

    chomp(@seq);

    unless (grep {length($_)!=$len} (@seq))
    {
	print STDOUT join("", @input[0..3]);
	print STDERR join("", @input[4..7]);

	$num_pairs++;
    }

    last if ($num_pairs >= $max_reads);
}

close(READS) || die;
close(MATES) || die;
