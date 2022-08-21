
ui <- function(input) {
  box::use(
    shiny,
    s = shiny,
    bs4Dash,
    box / ui / documentation,
    box / ui / installation,
    box / terminal / shinyAce
  )

  bs4Dash$dashboardPage(
    fullscreen = TRUE, dark = TRUE, title = "r-bedrock",
    header = bs4Dash$dashboardHeader(
      border = TRUE,
      compact = FALSE
    ),
    sidebar = bs4Dash$dashboardSidebar(
      width = "500px", expandOnHover = TRUE,
      bs4Dash$accordion(
        id = "accordionSidebar",
        bs4Dash$accordionItem(
          title='File Choice',
          collapsed=FALSE,
          s$div('Sidebar')
        ),
        bs4Dash$accordionItem(
          title = "Description",
          # status = "info",
          # collapsed = FALSE
          'sidebar'
        )
      )
    ),
    bs4Dash$dashboardBody(
      shiny$fluidRow(
        column(
          12, 
          s$uiOutput("directories"),
          s$uiOutput("files"),
          documentation$ui(),
          shinyAce$ui()
        )
      )
    ),
    controlbar = bs4Dash$dashboardControlbar(
      collapsed = TRUE,
      div(class = "p-3", bs4Dash$skinSelector()),
      pinned = TRUE
    )
  )
}

server <- function(input, output, session) {
  box::use(
    s = shiny, fs,
    box / ui / documentation,
    box / terminal / shinyAce
  )


  documentationInputs <- documentation$server()
  shinyAce$server(default_value = documentationInputs)
}


box::use(shiny[shinyApp])
shinyApp(ui, server)
