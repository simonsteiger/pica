box::use(
    shiny[actionButton, icon],
    shiny.router[change_page]
)

#' @export
btn_return <- function(id) {
    actionButton(
        id,
        label = "Back",
        icon = icon("angles-left"),
        # class = "hover"
    )
}
