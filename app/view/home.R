box::use(
    shiny[div, moduleServer, NS, renderUI, tags, icon, tagList, uiOutput, actionButton, observeEvent],
    purrr[map],
    shiny.router[change_page],
    shinyjs[disable],
)

box::use(
    app / logic / frontend[row2],
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
                            class = "d-flex flex-column justify-content-center align-items-center text-center mt-5",
                            tags$h1("What are you up to?", style = "margin-bottom: 2rem;"),
                            tags$img(style = "margin-right: 25rem;", src = "static/logo.png", width = "200px")
                        ),
                        div(
                            class = "d-flex flex-row justify-content-center gap-3",
                            actionButton(ns("upload"), "Uploading data!"),
                            actionButton(ns("visual"), "Visualizations!")
                        ),
                        div(
                            class = "d-flex flex-row justify-content-center mt-3",
                            tags$a(
                                href = "https://www.github.com/simonsteiger/pica",
                                target = "_blank",
                                class = "btn btn-default",
                                div(
                                    class = "d-flex flex-row align-items-center gap-2 small",
                                    icon(class = "fs-4", "github"),
                                    "Code!"
                                )
                            )
                        )
                    ),
                    NULL
                )
            )
        )
    )
}

#' @export
server <- function(id, pages) {
    moduleServer(id, function(input, output, session) {
        wrap_change_page <- function(page) {
            observeEvent(input[[page]], {
                change_page(page)
            })
        }

        map(pages, \(page) wrap_change_page(page))
    })
}
