use strict;
use warnings;
use Test::More tests => 6;

use JSON::Syck;

TODO: {
    local $TODO = 'JSON::Syck should be able to dump duplicate pointers in a structure';

    my $foo = bless { }, "Foo";
    my $bar = bless { foo => $foo }, "Bar";
    $foo->{bar} = $bar;

    my $result = eval { JSON::Syck::Dump($foo) };
    isnt($result, undef, "A Structure should come back on a JSON dump with circular blessed references");
    is($@, '', "No die is thrown when the circular ref happens");
}

TODO: {
    local $TODO = 'JSON::Syck should be able to dump circular pointers in a structure';

    my $foo = {};
    my $bar = { foo => $foo };
    $foo->{bar} = $bar;

    my $result = eval { JSON::Syck::Dump($foo) };
    isnt($result, undef, "A Structure should come back on a JSON dump with duplicate references");
    is($@, '', "No die is thrown when the circular ref happens");
    diag explain $foo;
}


TODO: {
    local $TODO = "There's no reason this shouldn't work. JSON::Syck should be able to dump duplicate pointers in a structure";

    my $foo = {};

    my $result = eval { JSON::Syck::Dump([$foo, $foo]) };
    isnt($result, undef, "A Structure should come back on a JSON dump with duplicate references");
    is($@, '', "No die is thrown when the circular ref happens");
    diag explain $foo;
}

