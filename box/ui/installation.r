#' @export
ui <- function(id = "installation") {
  box::use(s = shiny[withTags, NS, t = tags], bs4Dash[ui_box = box])
  box::use(mod = .. / bs4Mod / box)
  ns <- NS(id)
  mod$box(
    title = t$h3("Installation Steps"),
    withTags(
      div(
        ul(
          li(
            a(
              "Install R",
              href = "https://cran.r-project.org/mirrors.html)"
            )
          ),
          li(
            a(
              "Install RStudio",
              href = "https://www.rstudio.com/products/rstudio/download/"
            )
          ),
          li(
            a(
              "Windows Only Install RTools",
              href = "https://cran.r-project.org/bin/windows/Rtools/"
            )
          ),
          li(
            a(
              "Install Node and NPM",
              href = "https://phoenixnap.com/kb/install-node-js-npm-on-windows"
            )
          ),
          li(
            a(
              "Install Dart Sass",
              href = "https://sass-lang.com/install"
            )
          )
        )
      )
    )
  )
}
