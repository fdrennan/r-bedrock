#' @export
ui <- function(id='shinyAce') {
  box::use(s=shiny,a=shinyAce, ../bs4Mod/box)
  
  modes <- a$getAceModes()
  themes <- a$getAceThemes()
  
  init <- "createData <- function(rows) {
  data.frame(col1 = 1:rows, col2 = rnorm(rows))
}"
  
  ns <- s$NS(id)
  box$box(
    s$pageWithSidebar(
      s$headerPanel("Simple Shiny Ace!"),
      s$sidebarPanel(
        s$selectInput(ns("mode"), "Mode: ", choices = modes, selected = "r"),
        s$selectInput(ns("theme"), "Theme: ", choices = themes, selected = "ambience"),
        s$numericInput(ns("size"), "Tab size:", 4),
        s$radioButtons(ns("soft"), NULL, c("Soft tabs" = TRUE, "Hard tabs" = FALSE), inline = TRUE),
        s$radioButtons(ns("invisible"), NULL, c("Hide invisibles" = FALSE, 
                                                "Show invisibles" = TRUE), inline = TRUE),
        s$actionButton(ns("reset"), "Reset text"),
        s$actionButton(ns("clear"), "Clear text"),
        s$actionButton(ns("submit"), "Send text"),
        s$HTML("<hr />"),
        s$helpText(s$HTML("A simple Shiny Ace editor.
                  <p>Created using <a href = \"http://github.com/trestletech/shinyAce\">shinyAce</a>."))
      ),
      s$mainPanel(
        a$aceEditor(
          outputId = ns("ace"),
          selectionId = ns("selection"),
          value = init,
          placeholder = "Show a placeholder when the editor is empty ..."
        )
      )
    )
  )
}
 #' @export
server <- function(id='shinyAce') {
  
  box::use(a=shinyAce,s=shiny, sys,r=readr)
  
  s$moduleServer(
    id,
    function(input, output, session) {
      
      ns <- session$ns
     
      s$observe({
        a$updateAceEditor(
          session,
          "ace",
          theme = input$theme,
          mode = input$mode,
          tabSize = input$size,
          useSoftTabs = as.logical(input$soft),
          showInvisibles = as.logical(input$invisible)
        )
      })
      
      s$observeEvent(input$reset, {
        a$updateAceEditor(session, "ace", 
                          value = "createData <- function(rows) {
                                      data.frame(col1 = 1:rows, col2 = rnorm(rows))
                                  }")
      })
      
      s$observeEvent(input$clear, {
        a$updateAceEditor(session, "ace", value = "")
      })
      
      s$observeEvent(input$submit, {
        
       sys$exec_wait(cmd = 'ls -lah', std_out = 'out.txt')
       s$showModal(
         s$tags$pre(
           r$read_file('out.txt')
         )
       )
        
      })
    }
  )
}