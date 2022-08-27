box::use(shiny[shinyApp])

ui <- function() {
  box::use(./box/app[ui_app])
  ui_app()
}



server <- function(input, output, session) {
  box::use(./box/app[server_app])
  server_app(parentSession=session)
}

shinyApp(ui, server)