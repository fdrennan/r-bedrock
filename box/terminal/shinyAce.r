#' @export
ui <- function(id = "shinyAce") {
  box::use(shiny)
  ns <- s$NS(id)
  bs4Dash$box(
    title = "Terminal",
    width = 12,
    shiny$fluidRow(
      shiny$column(
        4,
        shinyAce$aceEditor(
          vimKeyBinding = TRUE, height = "100px",
          outputId = ns("ace"),
          value = "ls -lah",
          placeholder = ""
        ),
        shiny$actionButton(
          ns("submit"), 
          "Submit", 
          class = "btn btn-primary btn-block btn-small"
        )
      ),
      shiny$column(8,
        shiny$uiOutput(ns("aceOutput"))
      )
    )
  )
}
#' @export
server <- function(id = "shinyAce") {
  box::use(shinyAce, shiny, sys, readr, bs4Dash)

  shiny$moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      
      results <- shiny$eventReactive(
        input$submit,
        {
          tmp <- tempfile()
          sys$exec_wait(cmd = input$ace, std_out = tmp)
          shiny$tags$pre(
            readr$read_file(tmp)
          )
        }
      )
      
      output$aceOutput <- s$renderUI({
        results()
      })
      

      shiny$observeEvent(input$reset, {
        shinyAce$updateAceEditor(session, ns("ace"),
          value = "ls -lah"
        )
      })

      shiny$observeEvent(input$clear, {
        shinyAce$updateAceEditor(session, ns("ace"), value = "")
      })
    }
  )
}
