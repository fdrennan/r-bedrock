
#' @export
ui <- function(id = "sources") {
  box::use(s = shiny[withTags, NS, t = tags], b = bs4Dash)
  box::use(mod = .. / bs4Mod / box)
  ns <- NS(id)
  mod$box(
    title = t$h3("Sources"),
    t$a("The Economist", href = "https://economist.com")
  )
}
