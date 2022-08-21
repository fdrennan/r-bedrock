

root_page <- function() {
  box::use(bs4Dash, shiny)
  box::use(box / ui / documentation)
  box::use(box / terminal / shinyAce)
  shiny$wellPanel(shiny$uiOutput("directories"),
                  shiny$uiOutput("files"),
                  documentation$ui(),
                  shinyAce$ui())
}

blog_page <- function() {
  box::use(shiny)
  
  shiny$div('Ramblings')
}

box::use(shiny.router)

router <- shiny.router$make_router(
  shiny.router$route("/", root_page()),
  shiny.router$route("blog", blog_page()),
  page_404 = shiny.router$page404(
    message404 = "Please check if you passed correct bookmark name!")
)


ui <- function(input) {
  box::use(
    shiny,
    s = shiny,
    bs4Dash
  )

  # browser()
  bs4Dash$dashboardPage(body = bs4Dash$dashboardBody(router$ui),
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
          s$actionButton('goToHome', 'Home'),
          s$actionButton('goToBlog', 'Ramblings')
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

  router$server(input, output, session)
  
  observeEvent(input$goToHome, {
    shiny.router$change_page('/')
  })
  
  observeEvent(input$goToBlog, {
    shiny.router$change_page('/blog')
  })
  
  documentationInputs <- documentation$server()
  shinyAce$server(default_value = documentationInputs)
}


box::use(shiny[shinyApp])
shinyApp(ui, server)
