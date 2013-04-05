-module(gametypes_tests).
-include("../include/gametypes.hrl").
-include_lib("eunit/include/eunit.hrl").

orientations_test_() ->
    O = #orientations{},
    [
        ?_assertEqual(1, O#orientations.up),
        ?_assertEqual(2, O#orientations.down),
        ?_assertEqual(3, O#orientations.left),
        ?_assertEqual(4, O#orientations.right)
    ].

%% not necessary to test all
message_test_() ->
    M = #messages{},
    [
        ?_assertEqual({0, "hello"}, M#messages.hello),
        ?_assertEqual({26, "check"}, M#messages.check)
    ].

entities_test_() ->
    E = #entities{},
    [
        ?_assertEqual(1, E#entities.warrior),
        ?_assertEqual(20, E#entities.firefox),
        ?_assertEqual(35, E#entities.flask)
    ].

get_message_type_as_string_test_() ->
    M = #messages{},
    [
        ?_assertEqual("hello", get_message_type_as_string(M#messages.hello)),
        ?_assertEqual("check", get_message_type_as_string(M#messages.check))
    ].

get_kind_as_string_test_() ->
    ?_assertEqual({warrior, [#entities.warrior, "player"]}, get_kind_as_string(#entities.warrior)).

get_kind_from_string_test_() ->
    ?_assertEqual({warrior, [#entities.warrior, "player"]}, get_kind_from_string(warrior)).

get_type_test_() ->
    ?_assertEqual("player", get_type(#entities.warrior)).

is_mob_test_() ->
    [
        ?_assertEqual(true, is_mob(#entities.rat)),
        ?_assertEqual(true, is_mob(#entities.skeleton)),
        ?_assertEqual(false, is_mob(#entities.warrior))
    ].
