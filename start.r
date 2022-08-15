
ui <- function(input) {
  box::use(
    s = shiny,
    b = bs4Dash,
    box / ui / documentation,
    box / ui / sources,
    box / ui / installation,
  )

  b$dashboardPage(
    b$dashboardHeader(
      compact = TRUE
    ),
    b$dashboardSidebar(disable = TRUE),
    b$dashboardBody(
      s$fluidRow(
        class = "d-flex flex-column",
        b$sortable(
          installation$ui(),
          documentation$ui(),
          sources$ui()
        )
      )
    )
  )
}

server <- function(input, output, session) {
  box::use(
    box / ui / documentation
  )
  
  documentation$server()
  
}


box::use(shiny[shinyApp])
shinyApp(ui, server)
