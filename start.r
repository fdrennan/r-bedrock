
ui <- function(input) {
  box::use(s = shiny, b = bs4Dash, box / ui[installation, documentation])
  b$dashboardPage(
    b$dashboardHeader(disable = TRUE),
    b$dashboardSidebar(disable = TRUE),
    b$dashboardBody(
      s$fluidRow(
        s$includeCSS("www/styles.css"),
        installation(),
        documentation()
      )
    )
  )
}

server <- function(input, output, session) {

}

callShiny <- function(ui, server) {
  box::use(shiny[shinyApp])
  shinyApp(ui, server)
}


callShiny(ui, server)
