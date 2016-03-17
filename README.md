fifocache
=====

**fifocache** is a fixed size FIFO cache implementation in Erlang.

FIFO cache is sometimes necessary.

## Usage

```
1> Cache0 = fifocache:new(10).
{fifocache,#{},{array,10,0,undefined,10},10,0,false}
2> Cache1 = fifocache:push(key0, value0, Cache0).
{fifocache,#{key0 => {value0,1}},
           {array,10,0,undefined,
                  {key0,undefined,undefined,undefined,undefined,undefined,
                        undefined,undefined,undefined,undefined}},
           10,1,false}
3> value0 = fifocache:lookup(key0, Cache1).
value0
4> not_found = fifocache:lookup(key1, Cache1).
not_found
```

## License
[Apache License 2.0](LICENSE)
