-module(fib_tests).
-include_lib("eunit/include/eunit.hrl").

fib_1_test() ->
    ?assertEqual(1,fib:fib(1)).

fib_0_test() ->
    ?assertEqual(1, fib:fib(0)).

fib_2_test() ->
    ?assertEqual(2, fib:fib(2)).

fib_5_test() ->
    ?assertEqual(8, fib:fib(5)).
