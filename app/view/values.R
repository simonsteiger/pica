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
                            sh$tags$img(style = "margin-right: 22rem;", src = "static/logo.png", width = "200px")
                        ),
                        sh$div(
                            class = "d-flex flex-wrap flex-row justify-content-center align-items-center gap-3",
                            pr$map(1:6, \(x) sh$numericInput(ns(paste0("v", x)), paste0("Mean ", x), x, 0, 10, width = "25%")),
                            sh$actionButton(ns("confirm"), icon = sh$icon("paper-plane"), "Done", class = "btn-confirm"),
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

        # When confirm button is clicked, create table and upload to drive
        sh$observeEvent(input$confirm, {
            # Create table based on inputs
            table <- tbl$tibble(
                v1 = input$v1,
                v2 = input$v2,
                v3 = input$v3,
                v4 = input$v4,
                v5 = input$v5,
                v6 = input$v6
            )
            # Uncomment the line below and replace `id` with an identifier, such as the sheet URL, file id, or see
            # https://googlesheets4.tidyverse.org/reference/sheet_append.html
            # sheet_append(id, table, sheet = 1)
            sh$showNotification("Upload successful! 🎉")
        })

        #
    })
}
