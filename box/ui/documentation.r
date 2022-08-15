#' @export
ui <- function(id = "documentation") {
  box::use(mod = .. / bs4Mod / box)
  box::use(fs)
  box::use(s = shiny[t = tags], b = bs4Dash)
  ns <- s$NS(id)
  mod$box(
    title = t$h3("Documentation"),
    s$withTags(div(
      ul(
        li(
          a("bs4Dash", href = "https://rinterface.github.io/bs4Dash/index.html")
        )
      )
    )),
    sidebar = b$boxSidebar(
      s$uiOutput(ns('directories')),
      s$uiOutput(ns('files'))
    )
  )
}

#' @export
server <- function(id = "documentation") {
  box::use(s=shiny)
  s$moduleServer(
    id,
    function(input, output, session) {
      box::use(fs)
      ns <- session$ns
      output$directories <- s$renderUI({
        directories <- fs$dir_ls('box', recurse = TRUE, type = 'directory')
        s$selectizeInput(ns('boxDirectory'), 'Directory', choices=directories)
      })
      
      output$files <- s$renderUI({
        s$req(input$boxDirectory)
        files <- fs$dir_ls(input$boxDirectory, recurse = TRUE)
        s$selectizeInput(ns('dirFiles'), 'Files', choices=files)
      })
      
    }
  )
}
