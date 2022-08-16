
ui <- function(input) {
  box::use(
    s = shiny,
    b = bs4Dash,
    box / ui / documentation,
    box / ui / installation,
    box / terminal / shinyAce
  )

  b$dashboardPage(
    b$dashboardHeader(
      compact = TRUE
    ),
    b$dashboardSidebar(disable = TRUE),
    b$dashboardBody(
      s$fluidRow(
        installation$ui(),
        documentation$ui(),
        shinyAce$ui()
      )
    )
  )
}

server <- function(input, output, session) {
  box::use(
    box / ui / documentation,
    box / terminal / shinyAce
  )

  documentation$server()
  shinyAce$server()
}


box::use(shiny[shinyApp])
shinyApp(ui, server)
