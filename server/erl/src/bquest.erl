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
    init_server(),
    init_worlds(),
    init_metrics(),
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
-spec init_worlds() -> [supervisor:startchild_ret()].
init_worlds() ->
    {ok, PlayerMax} = application:get_env(bquest, nb_players_per_world),
    {ok, WorldNum}  = application:get_env(bquest, nb_worlds),
    [world:create(Idx, PlayerMax) || Idx <- lists:seq(1, WorldNum)].

-spec init_server() -> ok.
init_server() ->
    {ok, Port} = application:get_env(bquest, port),
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/bquest_ws", bquest_listener, []}
        ]}
    ]),
    SockOpts = #{port => Port},
    {ok, _} = cowboy:start_clear(bquest, [{num_acceptors, 25}], SockOpts),
    cowboy:set_env(bquest, dispatch, Dispatch).

-spec init_metrics() -> ok.
init_metrics() ->
    case application:get_env(bquest, metrics_enabled) of
        {ok, true} ->
            ok; %% TODO: initialize metrics
        _Else ->
            ok
    end.
