library(shiny)

ui <- function(input) {
  fluidPage(
    includeCSS("www/styles.css"),
    withTags(
      div(
        h1("This serves as a template for building applications in R."),
        h1("To get started, install the following."),
        a("Install R", href = "https://cran.r-project.org/mirrors.html)"),
        a("Install RStudio", href = "https://www.rstudio.com/products/rstudio/download/"),
        a("Windows Only Install RTools", href = "https://cran.r-project.org/bin/windows/Rtools/"),
        a("Install Node and NPM", href = "https://phoenixnap.com/kb/install-node-js-npm-on-windows"),
        code("npm install --global yarn")
      )
    )
  )
}

server <- function(input, output, session) {

}

shinyApp(ui, server)
