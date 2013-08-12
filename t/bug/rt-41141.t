#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 1;
use Test::Deep;

use YAML::Syck;

my $test_hash = {
    test => "?\r",
};

my $yaml = YAML::Syck::Dump($test_hash);
my $decoded = YAML::Syck::Load($yaml);
cmp_deeply(
    $decoded,
    $test_hash,
    'Produced YAML was successfully decoded'
);

