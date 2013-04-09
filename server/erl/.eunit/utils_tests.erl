-module(utils_tests).
-include("../include/gametypes.hrl").
-include_lib("eunit/include/eunit.hrl").

clamp_test_() ->
    [
        ?_assertEqual(1, utils:clamp(1, 5, 0)),
        ?_assertEqual(5, utils:clamp(1, 5, 10)),
        ?_assertEqual(4, utils:clamp(1, 5, 4))
    ].

distance_to_test_() ->
    [
        ?_assertEqual(3, utils:distance_to(1, 1, 4, 2)),
        ?_assertEqual(4, utils:distance_to(1, 1, 2, 5)),
        ?_assertEqual(2, utils:distance_to(2, 2, 4, 4))
    ].

%% from here on, these are bad tests. ideally, would want to make a service provider that provides a
%% real and faked random service and not depend on a seed being the same value.
random_test_() ->
    [
        ?_assertEqual(2, utils:random(5)),
        ?_assertEqual(3, utils:random(5))
    ].

random_range_test_() ->
    [
        ?_assert(utils:random_range(0, 5) < 6),
        ?_assert(utils:random_range(0, 5) >= 0)
    ].

random_orientation_test_() ->
    O = #orientations{},
    ?_assertEqual(O#orientations.right, utils:random_orientation()).
