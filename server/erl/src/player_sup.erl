%%%-------------------------------------------------------------------
%% @doc player_sup
%% @end
%%%-------------------------------------------------------------------
-module(player_sup).
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
    Spec = #{strategy  => simple_one_for_one,
             intensity => 10,
             period    => 1},

    Player = #{id => player,
               start => {player, start_link, []}},

    {ok, {Spec, [Player]}}.

%%====================================================================
%% Internal functions
%%====================================================================
