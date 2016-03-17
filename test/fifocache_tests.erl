-module(fifocache_tests).

-include_lib("eunit/include/eunit.hrl").


success_test() ->
    C0 = fifocache:new(2),
    C1 = fifocache:push(1, <<"a">>, C0),
    ?assertEqual(<<"a">>, fifocache:lookup(1, C1)),
    C2 = fifocache:push(2, <<"b">>, C1),
    ?assertEqual(<<"a">>, fifocache:lookup(1, C2)),
    C3 = fifocache:push(3, <<"c">>, C2),
    ?assertEqual(not_found, fifocache:lookup(1, C3)),
    ?assertEqual(<<"b">>, fifocache:lookup(2, C3)),
    ?assertEqual(<<"c">>, fifocache:lookup(3, C3)),

    C4 = fifocache:push(3, <<"d">>, C3),
    ?assertEqual(<<"d">>, fifocache:lookup(3, C4)),

    ok.

duplicate_test() ->
    C0 = fifocache:new(3),
    C1 = fifocache:push(1, <<"a">>, C0),
    C2 = fifocache:push(2, <<"b">>, C1),
    ?assertEqual(<<"a">>, fifocache:lookup(1, C2)),
    C3 = fifocache:push(1, <<"c">>, C2),
    ?assertEqual(<<"c">>, fifocache:lookup(1, C3)),
    C4 = fifocache:push(3, <<"d">>, C3),
    ?assertEqual(<<"c">>, fifocache:lookup(1, C4)),
    C5 = fifocache:push(4, <<"e">>, C4),
    ?assertEqual(<<"c">>, fifocache:lookup(1, C5)),
    C6 = fifocache:push(5, <<"f">>, C5),
    ?assertEqual(not_found, fifocache:lookup(1, C6)),
    ok.
