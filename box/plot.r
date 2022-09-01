#' @export
plot_ui <- function(id='plot') {
  box::use(shiny[fluidRow, column, plotOutput, NS])
  ns <- NS(id)
  fluidRow(
    'asdfadf',
    column(11, plotOutput(ns("plotOutput")))
  )
    
  
}

#' @export
plot_server <- function(id='plot', df, vbl, threshhold = NULL, parentSession) {
  box::use(shiny[moduleServer, renderPlot])
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    output$plotOutput <- renderPlot({
      plot(data.frame(1:10, 1:10))
    })
  }, session = parentSession)
}
