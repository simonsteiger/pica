box::use(
  shiny[div, moduleServer, NS, renderUI, tags, uiOutput],
  bslib[page],
  shiny.router[router_ui, router_server, route],
  googlesheets4[gs4_auth],
  googledrive[drive_token, drive_auth],
  shinyjs[useShinyjs],
  dotenv[load_dot_env],
  here[here],
)

box::use(
  app / view / home,
  app / view / upload,
  app / view / visual,
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
    theme = theme_light,
    router_ui(
      route(
        "/",
        home$ui(ns("home"))
      ),
      route(
        "upload",
        upload$ui(ns("upload"))
      ),
      route(
        "visual",
        visual$ui(ns("visual"))
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    router_server("/")
    home$server("home", page = c("upload", "visual"))
    upload$server("upload")
    visual$server("visual")
  })
}
