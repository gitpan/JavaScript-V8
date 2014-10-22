#!/usr/bin/perl
use Test::More;
use JavaScript::V8;
use utf8;
use strict;
use warnings;

my $context = JavaScript::V8::Context->new();

my $called_foo = 0;
$context->bind_function(foo => sub {
   $called_foo = 1; 
   'arg';
});

my $arg;
$context->bind_function(bar => sub {
    $arg = $_[0];
});

$context->eval("foo()");
ok($called_foo,'calling p5 function from js');
$context->eval("bar(foo())");
is $arg,'arg','passing arguments and return values';

done_testing;

