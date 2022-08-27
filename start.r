library(shiny)

ui_inner <- function(id='inner') {
  ns <- NS(id)
  uiOutput(ns('asdf'))
}

server_inner <- function(input, output, session) {
  output$asdf <- renderUI({
    tagList(
      'Hello how are you'
    )
  })
}

ui_home <- function(id='home') {
  ns <- NS(id)
  fluidRow(
    uiOutput(ns('ui')),
    ui_inner()
  )
}

server_home <- function(id='home', session, sesh) {
  moduleServer(
    id,
    function(input, output, session) {
      output$ui <- renderUI({
        'I am working'
      })
      
      callModule(server_inner, id='inner', session=sesh)
    }
  )
}



ui <- function() {
  ui_home()
}

server <- function(input, output, session) {
  server_home(sesh=session)
}

shinyApp(ui, server)