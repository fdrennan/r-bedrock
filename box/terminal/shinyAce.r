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
          5,
          a$aceEditor(
            outputId = ns("ace"),
            # selectionId = "selection",
            value = "ls -lah",
            placeholder = ""
          )
        ),
        s$column(
          5,
          s$uiOutput(ns("aceOutput"))
        )
    ),
    sidebar = b$boxSidebar(
      id = ns('sidebar'), startOpen = TRUE, easyClose = TRUE,
      s$selectInput(ns("mode"), "Mode: ", choices = modes, selected = "r"),
      s$selectInput(ns("theme"), "Theme: ", choices = themes, selected = "ambience"),
      s$numericInput(ns("size"), "Tab size:", 4),
      s$radioButtons(ns("soft"), NULL, c("Soft tabs" = TRUE, "Hard tabs" = FALSE), inline = TRUE),
      s$radioButtons(ns("invisible"), NULL, c(
        "Hide invisibles" = FALSE,
        "Show invisibles" = TRUE
      ), inline = TRUE),
      s$actionButton(ns("reset"), "Reset text"),
      s$actionButton(ns("clear"), "Clear text"),
      s$actionButton(ns("submit"), "Send text")
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
        a$updateAceEditor(
          session,
          ns("ace"),
          theme = input$theme,
          mode = input$mode,
          tabSize = input$size,
          useSoftTabs = as.logical(input$soft),
          showInvisibles = as.logical(input$invisible)
        )
      })

      s$observeEvent(input$reset, {
        a$updateAceEditor(session, ns("ace"),
          value = "ls -lah"
        )
      })

      s$observeEvent(input$clear, {
        a$updateAceEditor(session, ns("ace"), value = "")
      })

      output$aceOutput <- s$renderUI({
        input$submit
        # browser()
        tmp <- tempfile()
        sys$exec_wait(cmd = input$ace, std_out = tmp)
        s$tags$pre(
          r$read_file(tmp)
        )
      })
    }
  )
}
