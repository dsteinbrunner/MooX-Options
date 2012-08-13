#!perl
use strict;
use warnings;
use Test::Trap;

use Test::More;    # last test to print

{

    package r1Role;
    use Moo::Role;
    use MooX::Options;

    option 'r1' => ( is => 'ro' );
    1;
}
{

    package r2Role;
    use Moo::Role;
    use MooX::Options;

    option 'r2' => ( is => 'ro' );
    1;
}
{

    package t;
    use Moo;
    use MooX::Options;
    with 'r1Role', 'r2Role';
    option 'r3' => ( is => 'ro' );
    
    1
}

local $TODO = "Role not fully functional";
local @ARGV = ('--r1','--r2','--r3');
my $r;

trap {
    $r = t->new_with_options;
};
ok($r, 'r is defined');
if (defined $r) {
    ok($r->can('r1'), 'r1 exists');
    ok($r->can('r2'), 'r2 exists');
    ok($r->can('r3'), 'r3 exists');
    ok($r->r1(), 'r1 set');
    ok($r->r2(), 'r2 set');
    ok($r->r3(), 'r3 set');
}


done_testing;
