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
