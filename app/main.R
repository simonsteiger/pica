box::use(
  shiny[div, moduleServer, NS, renderUI, tags, uiOutput],
  bslib[page],
  shiny.router[router_ui, router_server, route]
)

box::use(
  app / view / home,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  page(
    router_ui(
      route(
        "/",
        home$ui(ns("home"))
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    router_server("/")
    home$server("home")
  })
}
