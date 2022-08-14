
ui <- function(input) {
  box::use(s = shiny, b = bs4Dash, box/ui)
  b$dashboardPage(
    b$dashboardHeader(title = b$dashboardBrand(
      title = "just my thoughts"
      # color = "primary"
      # href = "https://adminlte.io/themes/v3",
      # image = "https://adminlte.io/themes/v3/dist/img/AdminLTELogo.png"
    )),
    b$dashboardSidebar(disable = TRUE),
    b$dashboardBody(
      s$fluidRow(
        s$includeCSS("www/styles.css"),
        ui$installation(),
        ui$documentation(),
        ui$random_thoughts()
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

