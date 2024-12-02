Fun little problem.

I remember the first time I learned zip in ruby, I wondered why you would ever
put something so situational into the stdlib. Since then, I find I end up
finding uses for it semi-frequently.

A property of ruby a lot of people aren't aware of is enum-chaining. Most
`Enumerator` methods in ruby will return an enumerator, or will do that if not
given a block. That means that chained enumerators can execute lazily.
```ruby
list1.zip(list2).reduce(0) { ... }
```
The result of `zip` is an enumerator. Each iteration of reduce will force a
single iteration of zip. If the block were to be ommitted from reduce, it would
also be lazy. But given a block, it returns an array.

You can force lazyness even when a block is given to an enum chain by adding a
call to `lazy`. In this case, to force execution you need an explicit `.to_a` at
the end.
```ruby
list1.lazy.zip(list2).reduce(0) { ... } # => LazyEnumerator
```
There is a great irony that JS people consider their language functional and
rubyists consider their language OOP. Ruby has far more sophisticated functional
properties to it, and using them is considered idiomatic.
