<!-- README.md is generated from README.Rmd. Please edit that file -->
terser
======

A natural and terse syntax of function declaration in R for people who are interested in shooting yourself in the foot.

You can use `f(x, y) = x + y` to define a function `f`.

``` r
f(x, y) = x + y
f(3, 4)
#> [1] 7
```

> How... ?

> Yes! I overwrite the `=` operator.

If the left hand side is a symbol, it just does normal assignment like the `<-` operator. If the left hand side is a function call, it defines a function.

Some more examples:

``` r
x = 3
x
#> [1] 3

f(x, y) = x + y
f(2, 3)
#> [1] 5
identical(f, function(x, y) x + y)
#> [1] TRUE

g(x = 231) = log(x)
g()
#> [1] 5.442418
identical(g, function(x = 231) log(x))
#> [1] TRUE

h(a, b = a^2) = a + b
h(1)
#> [1] 2
h(1, 2)
#> [1] 3
identical(h, function(a, b = a^2) a + b)
#> [1] TRUE

tan2(a) = sin(a)/cos(a)
tan2(pi)
#> [1] -1.224647e-16

`∑`(...) = sum(...)
`∑`(2, 3, 4)
#> [1] 9
```

Warning
-------

The operator `=` can no longer do assignment for attributes and elements, the following will no longer work. Use `<-` instead.

``` r
names(x) <- c("a", "b", "c")
x[[2]] <- 32
```

See also
--------

This package is inspired by a syntax for defining a function in Julia.

    julia> f(x, y) = x + y
    f (generic function with 1 method)
