box::use(
    shiny[div, moduleServer, NS, renderUI, tags, tagList, uiOutput, actionButton, observeEvent],
    bslib[page_fixed, card, card_header, card_body],
    purrr[map],
    shiny.router[change_page],
)

box::use(
    app / logic / frontend[row2, head],
)

#' @export
ui <- function(id) {
    ns <- NS(id)
    tagList(
        div(
            class = "container-fluid",
            row2(
                colwidths = list(4, 4, 4),
                content = list(
                    NULL,
                    div(
                        div(
                            class = "d-flex flex-column justify-content-center text-center mt-5",
                            tags$h1("What are you up to?"),
                            tags$img(src = "static/logo.png", width = "200px")
                        ),
                        div(
                            class = "d-flex flex-row justify-content-center gap-3",
                            actionButton("goup", "Uploading data!"),
                            actionButton("godash", "Visualizations!")
                        ),
                    ),
                    NULL
                )
            )
        )
    )
}

#' @export
server <- function(id) {
    moduleServer(id, function(input, output, session) {
        wrap_change_page <- function(id) {
            observeEvent(input[[id]], {
                change_page(id)
            })
        }

        map(c("goup", "godash"), \(id) wrap_change_page(id))
    })
}
