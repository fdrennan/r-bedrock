#* Echo back the input
#* @param msg The message to echo
#* @export
echo <- function(msg="") {
  list(msg = paste0("The message is: '", msg, "'"))
}