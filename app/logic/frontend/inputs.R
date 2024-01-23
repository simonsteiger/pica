box::use(
    shiny[actionButton, icon]
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
