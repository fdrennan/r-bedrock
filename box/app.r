#' @description 
#' @export
ui_app <- function(id='app') {
  box::use(shiny[NS], ./home[ui_home])
  ns <- NS(id)
  ui_home()
}

#' @description 
#' 
#' @export
server_app <- function(id='app', session, parentSession) {
  box::use(
    ./home[server_home],
    shiny[moduleServer]
  )
  
  server_fn <- function(input, output, session) {
    server_home(parentSession=parentSession)
  }
  
  
  moduleServer(id,server_fn, session=parentSession)
}