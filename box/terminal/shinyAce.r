#' @export
ui <- function(id = "shinyAce") {
  box::use(s = shiny, a = shinyAce, .. / bs4Mod / box, b = bs4Dash)

  modes <- a$getAceModes()
  themes <- a$getAceThemes()


  ns <- s$NS(id)
  box$box(
    width = 12,
    s$fluidRow(
      s$column(
        4,
        a$aceEditor(
          outputId = ns("ace"),
          value = "ls -lah",
          placeholder = ""
        ),
        s$actionButton(ns("submit"), "Send text", class = "btn btn-primary btn-block btn-small")
      ),
      s$column(
        8,
        s$uiOutput(ns("aceOutput"))
      )
    )
  )
}
#' @export
server <- function(id = "shinyAce") {
  box::use(a = shinyAce, s = shiny, sys, r = readr)

  s$moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      s$observe({
        print(s$reactiveValuesToList(input))
      })
      s$observeEvent(input$reset, {
        a$updateAceEditor(session, ns("ace"),
          value = "ls -lah"
        )
      })

      s$observeEvent(input$clear, {
        a$updateAceEditor(session, ns("ace"), value = "")
      })


      results <- s$eventReactive(
        input$submit,
        {
          tmp <- tempfile()
          sys$exec_wait(cmd = input$ace, std_out = tmp)
          s$tags$pre(
            r$read_file(tmp)
          )
        }
      )
      output$aceOutput <- s$renderUI({
        results()
      })
    }
  )
}
