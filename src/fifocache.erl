-module(fifocache).

-export([new/1, push/3, lookup/2]).

-export_type([fifocache/0, fifocache/2]).

-record(fifocache, {
          cache :: #{_ => entry(_)},
          keys :: array:array(_),
          size :: non_neg_integer(),
          index :: non_neg_integer(),
          full :: boolean()
         }).

-type entry(Value) :: {Value, pos_integer()}.

-type fifocache() :: fifocache(term(), term()).

-opaque fifocache(Key, Value) :: #fifocache{cache :: #{Key => entry(Value)}, keys :: array:array(Key)}.


-spec new(Size :: pos_integer()) -> fifocache().
new(Size) ->
    #fifocache{cache = maps:new(), keys = array:new(Size), size = Size, index = 0, full = false}.

-spec push(Key, Value, fifocache(Key, Value)) -> fifocache(Key, Value).
push(Key, Value, #fifocache{cache = Cache, keys = Keys, size = Size, index = Index, full = true} = Fifocache) ->
    RemoveKey = array:get(Index, Keys),
    Cache0 = count_down(RemoveKey, Cache),
    Fifocache#fifocache{cache = count_up(Key, Value, Cache0), keys = array:set(Index, Key, Keys),
                        index = (Index + 1) rem Size};
push(Key, Value, #fifocache{cache = Cache, keys = Keys, size = Size, index = Index} = Fifocache) ->
    Fifocache#fifocache{cache = count_up(Key, Value, Cache), keys = array:set(Index, Key, Keys),
                        index = (Index + 1) rem Size, full = (Index == Size - 1)}.

-spec lookup(Key, fifocache(Key, Value)) -> Value | not_found.
lookup(Key, #fifocache{cache = Cache}) ->
    case maps:find(Key, Cache) of
        {ok, {Value, _}} ->
            Value;
        error ->
            not_found
    end.


%% Internal Functions

-spec count_up(Key, Value, #{Key => Value}) -> #{Key => Value}.
count_up(Key, Value, Cache) ->
    case maps:find(Key, Cache) of
        {ok, {_, Count}} ->
            maps:put(Key, {Value, Count + 1}, Cache);
        _ ->
            maps:put(Key, {Value, 1}, Cache)
    end.

-spec count_down(Key, #{Key => Value}) -> #{Key => Value}.
count_down(Key, Cache) ->
    case maps:find(Key, Cache) of
        {ok, {_, 1}} ->
            maps:remove(Key, Cache);
        {ok, {Value, N}} ->
            maps:put(Key, {Value, N - 1}, Cache)
    end.
