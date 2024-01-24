box::use(
    bslib[bs_theme, font_google, font_collection]
)

#' @export
light <- bs_theme(
  version = 5,
  base_font = font_collection(
    font_google("Roboto Mono", local = FALSE), "Roboto", "serif"
  ),
  heading_font = font_google("Roboto Mono"),
  code_font = font_google("Roboto Mono"),
  "btn-border-radius" = "0px",
  "btn-hover-bg" = "black"
)
