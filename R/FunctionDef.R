
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
#' Terser Function Declaration
#'
#' A terse syntax of function declaration for people who are interested in
#' shooting yourself in the foot.
#'
#' If left hand side is a symbol, it just do normal assignment like \code{<-}.
#'
#' If left hand side is a function call, e.g. f(x, y), it creates a function named "f"
#' which has formal arguments of "x", "y" and function body defined by the right hand side,
#' in the environment calling it.
#'
#' @param left A symbol or a function call.
#' @param right A R expression as body of the function.
#' @usage left = right
#'
#' @return The assigned value or function.
#' @export
#' @examples
#' x = 3
#' x
#'
#' f(x, y) = x + y
#' f(2, 3)
#' identical(f, function(x, y) x + y)
#'
#' g(x = 231) = log(x)
#' g()
#' identical(g, function(x = 231) log(x))
#'
#' h(a, b = a^2) = a + b
#' h(1)
#' h(1, 2)
#' identical(h, function(a, b = a^2) a + b)
#'
#' tan2(a) = sin(a)/cos(a)
#' tan2(pi)
`=` <- function (left, right) {
    left  <- substitute(left)
    right <- substitute(right)
    envir <- parent.frame()

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

