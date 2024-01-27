box::use(
  shiny[div, moduleServer, NS, renderUI, tags, uiOutput],
  bslib[page],
  shiny.router[router_ui, router_server, route],
  googlesheets4[gs4_auth],
  googledrive[drive_token, drive_auth],
  shinyjs[useShinyjs],
  dotenv[load_dot_env],
  here[here],
  shinyFeedback[useShinyFeedback],
)

box::use(
  app / view / home,
  app / view / tables,
  app / view / values,
  app / logic / frontend[theme_light],
)

load_dot_env(file = here(".env"))

# Authenticate Google sheets
drive_auth(cache = ".secrets", email = Sys.getenv("EMAIL"))
gs4_auth(token = drive_token(), email = Sys.getenv("EMAIL"))

#' @export
ui <- function(id) {
  ns <- NS(id)
  page(
    useShinyjs(),
    useShinyFeedback(),
    theme = theme_light,
    router_ui(
      route(
        "/",
        home$ui(ns("home"))
      ),
      route(
        "tables",
        tables$ui(ns("tables"))
      ),
      route(
        "values",
        values$ui(ns("values"))
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    router_server("/")
    home$server("home", page = c("tables", "values"))
    tables$server("tables")
    values$server("values")
  })
}
