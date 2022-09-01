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
    box::use(shiny[renderUI, fluidRow])
    box::use(bs4Dash)
    box::use(./plot[plot_server, plot_ui])
    ns <- session$ns
    output$landing <- renderUI({
      bs4Dash$dashboardPage(
        header = bs4Dash$dashboardHeader(),
        sidebar = bs4Dash$dashboardSidebar(),
        body = bs4Dash$dashboardBody(
          fluidRow(
            plot_ui(id=ns('plot')),
            plot_ui(id=ns('plot2'))
          )
        )
      )
    })
    plot_server(id=ns('plot'), parentSession=parentSession)
    plot_server(id=ns('plot2'), parentSession=parentSession)
  }
  
  moduleServer(
    id, server_fn,
    session=parentSession
  )
}