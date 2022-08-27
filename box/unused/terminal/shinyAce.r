#' @export
ui <- function(id = "shinyAce", default_value = "ls -lah") {
  box::use(shiny, bs4Dash, shinyAce)
  ns <- shiny$NS(id)
  bs4Dash$box(
    title = "Terminal",
    width = 12,
    shiny$fluidRow(
      shiny$column(
        12,
        shiny$div(
          class = "d-flex justify-content-between align-items-top",
          shiny$actionButton(
            ns("reset"),
            "Reset"
          ),
          shiny$actionButton(
            ns("clear"),
            "Clear"
          )
        ),
        shiny$div(
          class = "p-1",
          shinyAce$aceEditor(
            minLines = 30,
            maxLines = 30,
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
      shiny$column(
        12,
        shiny$uiOutput(ns("aceOutput"))
      )
    )
  )
}
#' @export
server <- function(id = "shinyAce", default_value = "ls -lah") {
  box::use(shinyAce, shiny, sys, readr, bs4Dash, fs, highlight)

  shiny$moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      results <- shiny$eventReactive(
        input$submit,
        {
          # tmp <- tempfile()
          # sys$exec(cmd = input$ace, std_out = tmp)
          # shiny$tags$pre(
            # readr$read_file(tmp)
          # )
          # browser()
          tf <- tempfile()
          readr$write_file(input$ace, file = tf )
          shiny$HTML(highlight$highlight( file = tf, detective = highlight$simple_detective, 
                     renderer = highlight$renderer_html( document = FALSE ) ))
          
          # shiny$tags$pre()
        }
      )

      output$aceOutput <- shiny$renderUI({
        results()
      })


      shiny$observe({
        shiny$req(default_value$dirFiles)
        shinyAce$updateAceEditor(session, "ace",
          value = readr$read_file(default_value$dirFiles), mode = fs$path_ext(default_value$dirFiles)
        )
      })

      shiny$observeEvent(input$clear, {
        shinyAce$updateAceEditor(session, "ace", value = "")
      })
    }
  )
}
