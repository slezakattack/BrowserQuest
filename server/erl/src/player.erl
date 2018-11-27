%%%-------------------------------------------------------------------
%% @doc player gen server.
%% @end
%%%-------------------------------------------------------------------
%% TODO: should be a gen_statem
%% States:
%% - connecting
%% - authenticated
-module(player).
-behaviour(gen_server).
-include("include/bquest.hrl").

%% API
-export([start_link/1, connect/0, process_message/2]).

%% Gen Server Callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
         code_change/3]).

%% State record
-record(state, {connection  :: pid(),
                statem      :: connecting | authenticated,
                world       :: undefined | pid(),
                entity_info :: undefined | entity_info()}).

%% Types
-type statem() :: connecting | authenticated.
-type state() :: #state{}.

%%===================================================================
%% API Functions
%%===================================================================
-spec start_link(pid()) -> {ok, pid()} | {error, term()}.
start_link(Conn) ->
    gen_server:start_link(?MODULE, [Conn], []).

-spec connect() -> {ok, pid()} | {error, term()}.
connect() ->
    case supervisor:start_child(player_sup, [self()]) of
        {ok, Pid} = Ret ->
            erlang:monitor(process, Pid),
            Ret;
        Error ->
            Error
    end.

-spec process_message(pid(), any()) -> ok | {text, message()}.
process_message(Player, Msg) ->
    gen_server:call(Player, {client_msg, Msg}).

%%===================================================================
%% Gen Server Callbacks
%%===================================================================
init([Conn]) ->
    {ok, #state{connection = Conn, statem = connecting}}.

%% websocket message to player
handle_call({client_msg, Message}, _From, #state{statem = StateM} = State) ->
    case handle_client_message(StateM, Message, State) of
        {ok, Reply, NewState} ->
            {reply, Reply, NewState};
        {ok, NewState} ->
            {reply, ok, NewState};
        {error, _Reason} = Error ->
            {stop, Error, State}
    end;
%% player message to websocket
handle_call({server_msg, _Message}, _From, State) ->
    {reply, ok, State};
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
-spec handle_client_message(statem(), message(), state())
            -> {ok, Reply, state()}
             | {ok, state()}
             | {error, term()}
        when
      Reply :: {text, message()}.
handle_client_message(connecting, #message_hello{name   = Name,
                                                 armor  = Armor,
                                                 weapon = Weapon}, State) ->
    EntityInfo = #entity_info{
                    name    = Name,
                    armor   = Armor,
                    weapon  = Weapon,
                    max_hp  = 100,
                    hp      = 100,
                    is_dead = false},

    Welcome = #message_welcome{
                connId    = 1,
                name      = Name,
                position  = {0, 0},
                hp = 100},

    {ok, World} = world:join(self()),
    NewState = State#state{statem      = authenticated,
                           world       = World,
                           entity_info = EntityInfo},
    {ok, {text, Welcome}, NewState};
handle_client_message(authenticated, #message_hello{}, _State) ->
    {error, protocol_error};
handle_client_message(authenticated, _Message, State) ->
    {ok, State}.
