%%%-------------------------------------------------------------------
%% @doc bquest gen server.
%% @end
%%%-------------------------------------------------------------------
-module(bquest).
-behaviour(gen_server).

%% API
-export([start_link/0]).

%% Gen Server Callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
         code_change/3]).

%% State record
-record(state, {}).

%% Types
-type state() :: #state{}.

%%===================================================================
%% API Functions
%%===================================================================
-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%%===================================================================
%% Gen Server Callbacks
%%===================================================================
init([]) ->
    create_worlds(),
    {ok, #state{}}.

handle_call(_Request, _From, State) ->
    {reply, ignored, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%===================================================================
%% Internal functions
%%===================================================================
create_worlds() ->
    {ok, PlayerMax} = application:get_env(bquest, nb_players_per_world),
    {ok, WorldNum}  = application:get_env(bquest, nb_worlds),
    [world:create(PlayerMax) || _ <- lists:seq(1, WorldNum)].
