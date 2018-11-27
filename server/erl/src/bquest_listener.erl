%%%-------------------------------------------------------------------
%% @doc bquest_listener.
%%
%% Websocket connection that relays decoded messages to player
%% process and encodes player messages back to receiver.
%% @end
%%%-------------------------------------------------------------------
-module(bquest_listener).

%% Cowboy Websocket Callbacks
-export([init/2, websocket_handle/2, websocket_info/2, terminate/3]).

-record(state, {player :: pid()}).

init(Req, []) ->
    {ok, Pid} = player:connect(),
    State = #state{player = Pid},
    {cowboy_websocket, Req, State}.

websocket_handle({text, Data}, #state{player = Pid} = State) ->
    %% decode data into map..
    case player:process_message(Pid, Data) of
        ok ->
            {ok, State};
        {text, _Msg} = TextMsg->
            {reply, TextMsg, State}
    end.

websocket_info({'DOWN', process, Pid, _Reason}, #state{player = Pid} = State) ->
    {stop, normal, State};
websocket_info(_Msg, State) ->
    {ok, State}.

terminate(_Reason, _Req, _State) ->
    ok.
