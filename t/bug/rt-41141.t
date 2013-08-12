#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

use YAML::Syck;

my %tests = (
    'ends with carriage return' => "?\r",
    'number ends with carrier return' => "42\r",
);

plan tests => 3 * scalar keys %tests;
while (my ($test, $value) = each (%tests))
{
    my $test_hash = { key => $value };
    my $yaml = YAML::Syck::Dump($test_hash);
    my $decoded = YAML::Syck::Load($yaml);

    cmp_deeply(
        $decoded,
        $test_hash,
        "hash: $test",
    );

    $yaml = YAML::Syck::Dump($value);
    $decoded = YAML::Syck::Load($yaml);
    is($value, $decoded, "scalar: $test");

    $yaml = YAML::Syck::Dump([$value]);
    $decoded = YAML::Syck::Load($yaml);
    cmp_deeply(
        [ $value ],
        $decoded,
        "array: $test",
    );
}

note 'Done!';

