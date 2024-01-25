box::use(
    shiny[tagList, NS, moduleServer, div, tags, textInput, fileInput, reactive, req, observe],
    tools[file_ext],
    vroom[vroom],
    googlesheets4[gs4_create],
    rlang[`%||%`],
)

box::use(
    app / logic / frontend[row2, head, btn_return],
    app / logic / backend[obs_return],
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
                            tags$h1("Tables? Thrilling..."),
                            tags$img(style = "margin-right: 25rem;", src = "static/logo.png", width = "200px")
                        ),
                        div(
                            class = "d-flex flex-column align-items-center gap-3",
                            textInput(ns("name"), "Name it!"),
                            fileInput(ns("file"), "Gimme it!", accept = ".csv", placeholder = "No file"),
                        ),
                        div(
                            class = "d-flex justify-content-center m-5",
                            btn_return(ns("return"))
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
    moduleServer(id, function(input, output, session) {
        # Return to home page if return button clicked
        obs_return(input)

        # Upload file to google drive
        observe({
            req(input$file)

            ext <- file_ext(input$file$name)
            data <- switch(ext,
                csv = vroom(input$file$datapath, delim = ","),
                # can add more extensions here
                validate("No likey. I collect only .csv shinies.")
            )

            # Uncomment this line to enable uploading to the authorized google drive account
            # gs4_create(input$name %||% "unnamed_sheet", sheets = list(sheet1 = data))
        })
    })
}