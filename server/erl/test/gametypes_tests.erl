-module(gametypes_tests).
-include("../include/gametypes.hrl").
-include_lib("eunit/include/eunit.hrl").

messages_test_() ->
    Message = #messages{},
    ?_assertEqual(25, Message#messages.open).
