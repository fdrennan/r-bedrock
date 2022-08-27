#' @export
ui_home <- function(id='home') {
  box::use(shiny[NS, uiOutput, fluidPage])
  ns <- NS(id)
  fluidPage(uiOutput(ns('landing')))
}

#' @export
server_home <- function(id='home', parentSession) {
  box::use(shiny[moduleServer])
  
  server_fn <- function(input, output, session) {
    box::use(shiny[renderUI])
    output$landing <- renderUI('Running')
  }
  
  moduleServer(
    id, server_fn,
    session=parentSession
  )
}