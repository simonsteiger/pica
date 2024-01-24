box::use(
    shiny[div, img],
    purrr[map],
    rlang[`%||%`],
)

#' @export
row2 <- function(content = list(), class = NULL, colwidths = list()) {
    stopifnot(length(content) == length(colwidths))
    stopifnot(is.numeric(unlist(colwidths)))
    stopifnot(sum(unlist(colwidths)) == 12)

    out <- map(seq_along(content), \(i) {
        div(
            class = paste0("col-lg-", colwidths[[i]], " col-sm-12"),
            content[[i]]
        )
    })

    div(
        class = class %||% "row m-4",
        out
    )
}

#' @export
head <- function(id, title) {
    row2(
        class = "row py-4 m-4 d-flex justify-content-center align-items-center",
        colwidths = list(2, 8, 2),
        content = list(
            div(btn_return(id)),
            div(class = "fs-1 h-font text-center", title),
            div(
                class = "justify-content-end",
                img(src = "static/logo.png", width = "100%")
            )
        )
    )
}
