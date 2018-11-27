%%%-------------------------------------------------------------------
%% @doc bquest_SUITE.
%% @end
%%%-------------------------------------------------------------------
-module(bquest_SUITE).
-include_lib("common_test/include/ct.hrl").
-include("include/bquest.hrl").

%%===================================================================
%% Common Test Callbacks
%%===================================================================
-export([all/0,
         init_per_suite/1, end_per_suite/1,
         init_per_testcase/2, end_per_testcase/2]).

%%===================================================================
%% Test Cases
%%===================================================================
-compile([export_all]).

%%===================================================================
%% Common Test Callbacks
%%===================================================================
all() -> [start_server,
          player_join].

init_per_suite(Config) ->
    {ok, _} = application:ensure_all_started(bquest),
    {ok, _} = fake_ws_client_sup:start(bquest_sup),
    Config.

end_per_suite(_Config) ->
    ok.

init_per_testcase(_All, Config) ->
    Config.

end_per_testcase(_All, _Config) ->
    ok.

%%===================================================================
%% Test Cases
%%===================================================================
start_server(_Config) ->
    1 = length(supervisor:which_children(world_sup)),
    {ok, 0, 200} = world:get_occupancy('world.1').

player_join(_Config) ->
    {ok, Pid} = fake_ws_client:connect("michael"),
    ExpectedWelcome = #message_welcome{connId = 1,
                                       name = "michael",
                                       position = {0, 0},
                                       hp = 100},
    [ExpectedWelcome] = fake_ws_client:get_messages(Pid),
    {ok, 1, 200} = world:get_occupancy('world.1').
