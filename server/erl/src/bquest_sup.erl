%%%-------------------------------------------------------------------
%% @doc bquest_sup
%% @end
%%%-------------------------------------------------------------------
-module(bquest_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================
-spec start_link() -> supervisor:start_child_ret().
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================
init([]) ->
    Spec = #{strategy  => rest_for_one,
             intensity => 10,
             period    => 1},

    WorldSup    = #{id    => world_sup,
                    start => {world_sup, start_link, []},
                    type  => supervisor},

    PlayerSup   = #{id    => player_sup,
                    start => {player_sup, start_link, []},
                    type  => supervisor},

    QuestServer = #{id    => bquest,
                    start => {bquest, start_link, []}},

    {ok, {Spec, [WorldSup, PlayerSup, QuestServer]}}.

%%====================================================================
%% Internal functions
%%====================================================================

