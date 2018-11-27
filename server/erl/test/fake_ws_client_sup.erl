%%%-------------------------------------------------------------------
%% @doc fake_ws_client_sup
%% @end
%%%-------------------------------------------------------------------
-module(fake_ws_client_sup).
-behaviour(supervisor).

%% API
-export([start/1, start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================
-spec start(pid()) -> supervisor:start_child_ret().
start(ParentSup) ->
    Spec = #{id => ?SERVER,
             start => {?SERVER, start_link, []},
             type  => supervisor},
    supervisor:start_child(ParentSup, Spec).

-spec start_link() -> supervisor:start_child_ret().
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================
init([]) ->
    Spec = #{strategy  => simple_one_for_one,
             intensity => 10,
             period    => 1},
    Child = #{id    => fake_ws_client,
              start => {fake_ws_client, start_link, []}},
    {ok, {Spec, [Child]}}.

%%====================================================================
%% Internal functions
%%====================================================================

