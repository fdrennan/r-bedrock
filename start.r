
ui <- function(input) {
  box::use(s = shiny, b = bs4Dash, box / ui)
  b$dashboardPage(
    b$dashboardHeader(
      compact = TRUE
    ),
    b$dashboardSidebar(disable = TRUE),
    b$dashboardBody(
      s$fluidRow(
        ui$installation(),
        ui$documentation(),
        ui$random_thoughts(),
        b$box(
          title = "Closable Box with dropdown",
          closable = TRUE,
          width = 12,
          status = "warning",
          solidHeader = FALSE,
          collapsible = TRUE,
          label = b$boxLabel(
            text = 1,
            status = "danger"
          ),
          dropdownMenu = b$boxDropdown(
            b$boxDropdownItem("Link to google", href = "https://www.google.com"),
            b$boxDropdownItem("item 2", href = "#"),
            b$dropdownDivider(),
            b$boxDropdownItem("item 3", href = "#", icon = icon("th"))
          ),
          sidebar = b$boxSidebar(
            startOpen = TRUE,
            id = "mycardsidebar",
            s$sliderInput(
              "obs",
              "Number of observations:",
              min = 0,
              max = 1000,
              value = 500
            )
          ),
          s$plotOutput("distPlot")
        )
      )
    )
  )
}

server <- function(input, output, session) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}


box::use(shiny[shinyApp])
shinyApp(ui, server)
