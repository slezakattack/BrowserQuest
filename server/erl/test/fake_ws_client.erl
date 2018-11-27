%%%-------------------------------------------------------------------
%% @doc fake_ws_client gen server.
%% @end
%%%-------------------------------------------------------------------
%% TODO: Send "HELLO"

-module(fake_ws_client).
-behaviour(gen_server).
-include("include/bquest.hrl").

%% API
-export([start_link/1, connect/1, get_messages/1]).

%% Gen Server Callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
         code_change/3]).

%% State record
-record(state, {player   :: pid(),
                messages :: [message()]}).

%% Types

%%===================================================================
%% API Functions
%%===================================================================
-spec start_link(string()) -> {ok, pid()} | {error, term()}.
start_link(Name) ->
    gen_server:start_link(?MODULE, [Name], []).

-spec connect(string()) -> supervisor:start_child_ret().
connect(Name) ->
    supervisor:start_child(fake_ws_client_sup, [Name]).

-spec get_messages(pid()) -> [message()].
get_messages(Pid) ->
    gen_server:call(Pid, get_messages).

%%===================================================================
%% Gen Server Callbacks
%%===================================================================
init([Name]) ->
    {ok, Pid} = player:connect(),
    HelloMsg = #message_hello{name = Name, armor = 1, weapon = 1},
    Resp = player:process_message(Pid, HelloMsg),
    Messages = record_response(Resp, []),
    {ok, #state{player = Pid, messages = Messages}}.

handle_call(get_messages, _From, #state{messages = Messages} = State) ->
    {reply, lists:reverse(Messages), State};
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
-spec record_response(ok | {text, message()}, [message()]) -> [message()].
record_response(ok, Messages) ->
    Messages;
record_response({text, Message}, Messages) ->
    [Message | Messages].
