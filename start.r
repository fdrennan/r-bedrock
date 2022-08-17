
ui <- function(input) {
  box::use(
     shiny,
    bs4Dash,
    box / ui / documentation,
    box / ui / installation,
    box / terminal / shinyAce
  )

  bs4Dash$dashboardPage(fullscreen = TRUE, dark = TRUE, title = 'r-bedrock',
    header=bs4Dash$dashboardHeader(border = TRUE,
      compact =FALSE
    ),
    sidebar = bs4Dash$dashboardSidebar(width = '500px',
      documentation$ui()
    ),
    controlbar = bs4Dash$dashboardControlbar(
      collapsed = TRUE,
      div(class = "p-3", bs4Dash$skinSelector()),
      pinned = TRUE
    ),
    bs4Dash$dashboardBody(
      shiny$fluidRow(
        # column(4,
        #   
        # ),
        column(
          12, shinyAce$ui()
        )
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
