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
    E = #entities{},
    ?_assertEqual({warrior, [E#entities.warrior, "player"]}, get_kind_as_string(E#entities.warrior)).

get_kind_from_string_test_() ->
    E = #entities{},
    ?_assertEqual({warrior, [E#entities.warrior, "player"]}, get_kind_from_string(warrior)).

get_type_test_() ->
    E = #entities{},
    ?_assertEqual("player", get_type(E#entities.warrior)).

is_mob_test_() ->
    E = #entities{},
    [
        ?_assertEqual(true, is_mob(E#entities.rat)),
        ?_assertEqual(true, is_mob(E#entities.skeleton)),
        ?_assertEqual(false, is_mob(E#entities.warrior))
    ].

is_npc_test_() ->
    E = #entities{},
    [
        ?_assertEqual(true, is_npc(E#entities.guard)),
        ?_assertEqual(true, is_npc(E#entities.lavanpc)),
        ?_assertEqual(false, is_npc(E#entities.warrior))
    ].

is_armor_test_() ->
    E = #entities{},
    [
        ?_assertEqual(true, is_armor(E#entities.firefox)),
        ?_assertEqual(true, is_armor(E#entities.goldenarmor)),
        ?_assertEqual(false, is_armor(E#entities.flask))
    ].

is_weapon_test_() ->
    E = #entities{},
    [
        ?_assertEqual(true, is_weapon(E#entities.sword1)),
        ?_assertEqual(true, is_weapon(E#entities.morningstar)),
        ?_assertEqual(false, is_weapon(E#entities.firefox))
    ].

is_object_test_() ->
    E = #entities{},
    [
        ?_assertEqual(true, is_object(E#entities.flask)),
        ?_assertEqual(true, is_object(E#entities.firepotion)),
        ?_assertEqual(false, is_object(E#entities.guard))
    ].
%is_item_test_() ->
%    E = #entities{},
%    [
%        ?_assertEqual(true, is_item(E#entities
%    ].
