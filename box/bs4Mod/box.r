#' @export
box <- function(...) {
  box::use(b = bs4Dash, s = shiny)
  b$box(
    maximizable = TRUE, collapsible = TRUE, closable = TRUE,
    ...
  )
}
