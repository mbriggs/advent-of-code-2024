# Part 1

Day 2 pt 1 was fun. `each_cons` is another one of those methods in ruby that is
more useful then you would originally think. A `cons` cell comes from the lisp
method. The idea is each cell is like a box with two compartments, where the
first holds a value, the second is a pointer to another cons cell or nothing.
This is a fundamental way of thinking about linked lists, since lisp is a
language where linked lists are the foundational principle everything else is
built on top of, they way its treated is helpful for orienting your mind around
how to think about lists.

```lisp
(a . nil) ; => (a)
(a . (b . nil)) ; => (a b)
(a . (b . (c . nil))) ; => (a b c)
```

`each_cons` in ruby references that elegance and simplicity, with a customizable
cons cell implementation (instead of tuples its arbitrary length cells), and
instead of having the link be part of the syntax, its intrinsic in the
iteration.

All those differences aside, every time I dust off `each_cons` it makes me
smile.


# Part 2

For part 2 I got into a trap. My first crack at it, I was trying to be hyper
efficient, and map out what level to remove based on which comparisons failed. I
realized at a certain point I was mired in a mess of complexity. When this
happens, I try to pause and ask myself "What am I even doing, do I need to do
this or am I making hard work for myself?".

That is a profound question, and one of the most important things I ever learned
how to do. The best solution to a hard problem is the realization the problem
does not need to be hard. I realized I was too focused on efficiency, and should
instead just try out each removal to see if it made the report work. After
deleting code and running it, things passed.

Another note here that this is the first time I extracted a function, and it was
for the purpose of re-use. A function is an abstraction, and all abstractions
have a cost. The time to use an abstraction is only ever when the cost outweighs
the benefit. In this case, reuse of the checking code promotes more clarity,
however this is not always the case. Never consider abstraction self-justifying
in principle. Things like "single responsibility" are guideposts, not laws of
the universe, and always must be applied in the context of the problem at hand.
