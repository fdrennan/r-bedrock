#' @export
installation <- function() {
  box::use(s = shiny[withTags, t = tags], bs4Dash[ui_box = box])
  ui_box(
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

#' @export
documentation <- function() {
  box::use(s = shiny[withTags, t = tags], bs4Dash[ui_box = box])
  ui_box(
    title = t$h3("Documentation"),
    withTags(div(
      ul(
        li(
          a("bs4Dash", href = "https://rinterface.github.io/bs4Dash/index.html")
        )
      )
    ))
  )
}



#' @export
#' @export
random_thoughts <- function() {
  box::use(s = shiny[withTags, t = tags], b = bs4Dash)
  b$box(
    title = t$h3("Sources"),
    t$a("The Economist", href = "https://economist.com")
  )
}
