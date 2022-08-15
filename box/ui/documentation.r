#' @export
ui <- function(id = "documentation") {
  box::use(mod = .. / bs4Mod / box)
  box::use(fs)
  box::use(s = shiny[t = tags], b = bs4Dash)
  ns <- s$NS(id)
  mod$box(
    title = t$h3("Documentation"),
    s$uiOutput(ns("file")),
    sidebar = b$boxSidebar(
      id = ns("sidebar"),
      s$uiOutput(ns("directories")),
      s$uiOutput(ns("files")),
      b$actionButton(ns("runStyle"), label = "Style Current File")
    )
  )
}

#' @export
server <- function(id = "documentation") {
  box::use(s = shiny)
  s$moduleServer(
    id,
    function(input, output, session) {
      box::use(fs, r = readr, h = highlight, styler)
      ns <- session$ns

      output$directories <- s$renderUI({
        directories <- fs$dir_ls("box", recurse = TRUE, type = "directory")
        directories <- c(getwd(), directories)
        s$selectizeInput(ns("boxDirectory"), "Directory", choices = directories)
      })

      output$files <- s$renderUI({
        s$req(input$boxDirectory)

        files <- fs$dir_ls(input$boxDirectory, recurse = TRUE, type='file')
        s$selectizeInput(ns("dirFiles"), "Files", choices = files)
      })

      s$observeEvent(input$runStyle, {
        styler$style_file(input$dirFiles)
        s$showNotification("Styling Complete")
      })

      output$file <- s$renderUI({
        s$req(input$dirFiles)
        s$HTML(h$highlight(input$dirFiles, renderer = h$renderer_html()))
      })
    }
  )
}
