#' @export
box <- function(...) {
  box::use(b = bs4Dash, s = shiny)
  b$box(
    width = 12, maximizable = TRUE, collapsible = TRUE,
    ...
  )
}
