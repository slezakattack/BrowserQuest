%%%-------------------------------------------------------------------
%% @doc world gen server.
%% @end
%%%-------------------------------------------------------------------
-module(world).
-behaviour(gen_server).

%% API
-export([start_link/2, create/2, get_occupancy/1, join/1]).

%% Gen Server Callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
         code_change/3]).

%% State record
-record(state, {
        max_players         :: pos_integer(),
        current_players = 0 :: non_neg_integer(),
        entities = []       :: [term()]}).

%% Types

%%===================================================================
%% API Functions
%%===================================================================
-spec start_link(pos_integer(), pos_integer()) -> {ok, pid()} | {error, term()}.
start_link(Idx, PlayerMax) ->
    Name = get_name(Idx),
    gen_server:start_link({local, Name}, ?MODULE, [PlayerMax], []).

-spec create(pos_integer(), pos_integer()) -> supervisor:startchild_ret().
create(Idx, PlayerMax) ->
    supervisor:start_child(world_sup, [Idx, PlayerMax]).

-spec get_occupancy(pid()) -> {ok, non_neg_integer(), non_neg_integer()}
                            | {error, term()}.
get_occupancy(World) ->
    gen_server:call(World, get_occupancy).

-spec join(pid()) -> {ok, pid()}
                   | {error, term()}.
join(Player) ->
    Idx = erlang:phash2(os:timestamp(), length(supervisor:which_children(world_sup))) + 1,
    Name = get_name(Idx),
    case gen_server:call(Name, {join, Player}) of
        ok ->
            {ok, Name};
        {error, _} = Error ->
            Error
    end.

%%===================================================================
%% Gen Server Callbacks
%%===================================================================
init([PlayerMax]) ->
    {ok, TickRate} = application:get_env(bquest, tick_rate),
    {ok, _Tref} = timer:send_interval((1000 div TickRate), flush_buffer),
    {ok, #state{max_players = PlayerMax}}.

handle_call(get_occupancy, _From, #state{max_players = MaxPlayers,
                                         current_players = CurrentPlayers} = State) ->
    {reply, {ok, CurrentPlayers, MaxPlayers}, State};
handle_call({join, Player}, _From, #state{current_players = CurrentPlayers,
                                          entities = Entities} = State) ->
    {reply, ok, State#state{current_players = CurrentPlayers + 1,
                            entities = [Player | Entities]}};
handle_call(_Request, _From, State) ->
    {reply, ignored, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(flush_buffer, State) ->
    %% Flush buffered messages to all players in world instance
    {noreply, State};
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%===================================================================
%% Internal functions
%%===================================================================
-spec get_name(pos_integer()) -> atom().
get_name(Idx) ->
    list_to_atom("world." ++ integer_to_list(Idx)).
