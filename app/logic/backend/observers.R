box::use(
    shiny[observeEvent],
    shiny.router[change_page],
)

#' @export
obs_return <- function(input) {
  observeEvent(input$return, {
    change_page("/")
  })
}