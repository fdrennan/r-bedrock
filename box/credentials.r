
#' @export
credentials <- function() {
  # define some credentials
  credentials <- data.frame(
    user = c("", "shinymanager"), # mandatory
    password = c("", "12345"), # mandatory
    start = c("2019-04-15"), # optinal (all others)
    expire = c(NA, "2019-12-31"),
    admin = c(FALSE, TRUE),
    comment = "Simple and secure authentification mechanism 
  for single ‘Shiny’ applications.",
  stringsAsFactors = FALSE
  )
  
  
}