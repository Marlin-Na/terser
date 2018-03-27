

args(`<-`)

funcDef <- function (formals, body, .env = parent.frame()) {
    env <- .env
    cat("wtf")
    body <- substitute(body)
    f <- substitute(formals)
    if (is.name(f)) {
        name <- deparse(f)
        args <- alist(... = )
    }
    else if (is.call(f)) {
        name <- deparse(f[[1]])
        args <- {
            n <- lapply(as.list(f[-1]), function(x) deparse(x))
            args <- rep(alist(xx = ), length(n))
            names(args) <- n
            args
        }
    }
    else stop()

    func <- pryr::make_function(args = args, body = body, env = env)
    assign(name, func, envir = env)
}



oper_init <- function (envir = parent.frame()) {
    env <- envir
    assign("=", value = funcDef, envir = env)
    invisible(TRUE)
}

oper_clear <- function (envir = parent.frame()) {
    env <- envir
    if (!identical(base::`=`, get("="))) {
        rm(`=`, envir = env)
        ans <- TRUE
    }
    else
        ans <- FALSE
    invisible(ans)
}

if (FALSE) {
    oper_init()
    
    f(x, y) = x + y
    f(1,2)
    
    oper_clear()
    
    f(x, y) = x + y
}





