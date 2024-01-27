box::use(
    sh = shiny,
    tbl = tibble,
    dp = dplyr,
    pr = purrr,
)

box::use(
    app / logic / frontend[row2, btn_return],
    app / logic / backend[obs_return],
)

#' @export
ui <- function(id) {
    ns <- sh$NS(id)
    sh$tagList(
        sh$div(
            class = "container-fluid",
            row2(
                colwidths = list(4, 4, 4),
                content = list(
                    NULL,
                    sh$div(
                        sh$div(
                            class = "d-flex flex-column justify-content-center align-items-center text-center mt-5",
                            sh$tags$h1("Many values, oof!", style = "margin-bottom: 2rem;"),
                            sh$tags$img(style = "margin-right: 25rem;", src = "static/logo.png", width = "200px")
                        ),
                        sh$div(
                            class = "d-flex flex-wrap flex-row justify-content-center align-items-center gap-3",
                            pr$map(1:6, \(x) sh$numericInput(ns(paste0("v", x)), paste0("Mean ", x), x, 0, 10, width = "100px")),
                            sh$actionButton(ns("confirm"), "Done, save!"),
                        ),
                        sh$div(
                            class = "d-flex justify-content-center m-5",
                            btn_return(ns("return"))
                        ),
                        sh$div(
                            sh$tableOutput(ns("table"))
                        )
                    ),
                    NULL
                )
            )
        )
    )
}

#' @export
server <- function(id) {
    sh$moduleServer(id, function(input, output, session) {
        obs_return(input)

        res <- sh$bindEvent(
            {
                sh$reactive(
                    tbl$tibble(
                        v1 = input$v1,
                        v2 = input$v2,
                        v3 = input$v3,
                        v4 = input$v4,
                        v5 = input$v5,
                        v6 = input$v6
                    )
                )
            },
            input$confirm
        )

        output$table <- sh$renderTable(res())
    })
}
