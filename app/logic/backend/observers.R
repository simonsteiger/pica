box::use(
  shiny[observeEvent, observe],
  shiny.router[change_page],
  rlang[`%||%`],
)

#' @export
obs_return <- function(input) {
  observe(
    input$return %||% warning("Trying to add `obs_return()`, but missing an input with id `return`.")
  )
  observeEvent(input$return, {
    change_page("/")
  })
}
