fifocache
=====

[![Build Status](https://travis-ci.org/mururu/fifocache.svg?branch=master)](https://travis-ci.org/mururu/fifocache)
[![hex.pm version](https://img.shields.io/hexpm/v/fifocache.svg)](https://hex.pm/packages/fifocache)


**fifocache** is a fixed size FIFO cache implementation (O(logN)) in Erlang.

FIFO cache is sometimes necessary.

## Usage

```
1> Cache0 = fifocache:new(2).
{fifocache,#{},{array,2,0,undefined,10},2,0,false}
2> Cache1 = fifocache:push(key0, value0, Cache0).
3> Cache2 = fifocache:push(key1, value1, Cache1).
4> Cache3 = fifocache:push(key2, value2, Cache2).
5> fifocache:lookup(key2, Cache3).
value2
6> fifocache:lookup(key0, Cache3).
not_found
```

## License
[Apache License 2.0](LICENSE)
