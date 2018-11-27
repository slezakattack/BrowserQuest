-ifndef('bquest.hrl').
-define('bquest.hrl', include_protection).
-export_type([message/0, entity_info/0]).

-type item() :: non_neg_integer().
-type health() :: non_neg_integer().
-type coordinate() :: {X :: integer(), Y :: integer()}.
-record(message_hello, {name   :: string(),
                        armor  :: item(),
                        weapon :: item()}).

-record(message_welcome, {connId   :: integer(),
                          name     :: string(),
                          position :: coordinate(),
                          hp       :: health()}).

-record(entity_info, {name    :: string(),
                      armor   :: integer(),
                      weapon  :: integer(),
                      max_hp  :: health(),
                      hp      :: health(),
                      is_dead :: boolean(), %% TODO: needed?
                      extra   :: map:map()}).

-type message() :: #message_hello{}
                 | #message_welcome{}.
-type entity_info() :: #entity_info{}.


-endif.
