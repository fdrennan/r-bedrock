#* Echo back the input
#* @param msg The message to echo
#* @export
sessionInfo <- function(msg = "") {
  box::use(u = utils, jsonlite[toJSON, unbox])
  session_info <- u$sessionInfo()
  unbox(toJSON(session_info$R.version))
}
