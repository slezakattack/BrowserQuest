%%%-------------------------------------------------------------------
%% @doc world gen server.
%% @end
%%%-------------------------------------------------------------------
-module(world).
-behaviour(gen_server).

%% API
-export([start_link/1, create/1]).

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
-spec start_link(pos_integer()) -> {ok, pid()} | {error, term()}.
start_link(PlayerMax) ->
    gen_server:start_link(?MODULE, [PlayerMax], []).

-spec create(pos_integer()) -> supervisor:startchild_ret().
create(PlayerMax) ->
    supervisor:start_child(world_sup, [PlayerMax]).

%%===================================================================
%% Gen Server Callbacks
%%===================================================================
init([]) ->
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
