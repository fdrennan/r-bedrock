box::use(shiny[shinyApp])
box::use(shinymanager[secure_app, check_credentials, secure_server])

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

ui <- function() {
  box::use(./box/app[ui_app])
  ui_app()
}

ui <- secure_app(ui())


server <- function(input, output, session) {
  box::use(./box/app[server_app])
  # call the server part
  # check_credentials returns a function to authenticate users
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials)
  )
  
  server_app(parentSession=session)
}

shinyApp(ui, server)