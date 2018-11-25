-module(utils).
-export([random/1, random_range/2, random_int/2, clamp/3, random_orientation/0, distance_to/4]).
-include("include/gametypes.hrl").

%% need to find a way to test: random, random_range, random_int, random_orientation
random(Range) when is_integer(Range) ->
    trunc(rand:uniform() * Range).

random_range(Min, Max) ->
    (rand:uniform() * (Max - Min)) + Min.

random_int(Min, Max) ->
    Min + trunc(rand:uniform() * (Max - Min + 1)).

random_orientation() ->
    R = utils:random(4),
    O = #orientations{},
    case R of
        0 -> O#orientations.left;
        1 -> O#orientations.right;
        2 -> O#orientations.up;
        3 -> O#orientations.down;
        _ -> O#orientations.left
    end.

clamp(_Min, Max, Value) when Value > Max ->
    Max;
clamp(Min, _Max, Value) when Value < Min ->
    Min;
clamp(_Min, _Max, Value) ->
    Value.

distance_to(X, Y, X2, Y2) when abs(X - X2) >= abs(Y - Y2)->
    abs(X - X2);
distance_to(X, Y, X2, Y2) when abs(X - X2) < abs(Y - Y2) ->
    abs(Y - Y2).
