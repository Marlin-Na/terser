
l2namedl <- function(lst) {
    ans <- lst
    for (i in seq_along(lst)) {
        if (is.null(names(lst)) || names(lst)[[i]] == "") {
            names(ans)[[i]] <- as.character(as.name(lst[[i]]))
            ans[[i]] <- substitute()
        }
    }
    ans
}

# terse_assign
#' @export
`=` <- function (left, right, envir = parent.frame()) {
    left  <- substitute(left)
    right <- substitute(right)

    if (is.name(left))
        return(invisible(eval(call("<-", left, right), envir = envir)))
    if (is.call(left)) {
        name <- as.character(as.name(left[[1]]))

        # Some cases that may indicate an invalid use (todo: add more)
        if (name %in% c("[", "[[", "[<-", "[[<-", "$", "$<-", "=", "<-", "@", "@<-"))
            stop(sprintf("You are going to re-define %s, it is hightly likely a mistake", name))
        if (name %in% c("names", "attributes", "dim", "dimnames", "colnames", "rownames"))
            warning(sprintf("You are going to re-define %s, it is likely a mistake", name))

        args <- as.pairlist(l2namedl(as.list(left[-1])))
        return(invisible(eval(call("<-", name, call("function", args, right)), envir = envir)))
    }
    stop()
}


if (FALSE) {

    x = 3

    f(x, y) = x + y
    f(2, 3)
    identical(f, function(x, y) x + y)

    g(x = 231) = log(x)
    g()
    identical(g, function(x = 231) log(x))

    h(a, b = a^2) = a + b
    h(1)
    h(1, 2)
    identical(h, function(a, b = a^2) a + b)

    tan2(a) = sin(a)/cos(a)
    gg(a) = sin(a)
    gg(32)
}


