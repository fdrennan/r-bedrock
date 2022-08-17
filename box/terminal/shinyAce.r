#' @export
ui <- function(id = "shinyAce", default_value='ls -lah') {
  box::use(shiny, bs4Dash, shinyAce)
  ns <- shiny$NS(id)
  bs4Dash$box(
    title = "Terminal",
    width = 12,
    shiny$fluidRow(
      shiny$column(4,
        shiny$div(
          class='p-1',
          shinyAce$aceEditor(
            minLines=40,
            maxLines=40,
            autoScrollEditorIntoView = TRUE,
            vimKeyBinding = TRUE, showLineNumbers = TRUE, 
            theme = "pastel_on_dark",
            highlightActiveLine = TRUE, 
            outputId = ns("ace"),
            value = default_value,
            placeholder = ""
          )
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
server <- function(id = "shinyAce", default_value='ls -lah') {
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
      
      output$aceOutput <- shiny$renderUI({
        results()
      })
      

      shiny$observeEvent(input$reset, {
        shinyAce$updateAceEditor(session, ns("ace"),
          value = default_value
        )
      })

      shiny$observeEvent(input$clear, {
        shinyAce$updateAceEditor(session, ns("ace"), value = "")
      })
    }
  )
}
