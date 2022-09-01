box::use(shiny[shinyApp])
box::use(shinymanager[secure_app])

ui <- function() {
  box::use(./box/app[ui_app])
  ui_app()
}
 
ui <- secure_app(ui())

server <- function(input, output, session) {
  box::use(./box/app)
  box::use(./box/credentials[credentials])
  box::use(shinymanager[check_credentials, secure_server])
  
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials())
  )
  app$server_app(parentSession=session)
}

shinyApp(ui, server)