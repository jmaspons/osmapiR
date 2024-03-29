# inspired by osmdata package

.onLoad <- function(libname, pkgname) { # nocov start
  op <- options()

  if (!"osmapir.osmapir_version" %in% names(op)) {
    options(osmapir.osmapir_version = utils::packageVersion("osmapiR"))
  }

  if (!"osmapir.user_agent" %in% names(op)) {
    options(
      osmapir.user_agent = paste(
        "osmapiR", getOption("osmapir.osmapir_version"), "(https://github.com/jmaspons/osmapiR)"
      )
    )
  }

  if (!"osmapir.base_api_url" %in% names(op)) {
    options(osmapir.base_api_url = "https://api.openstreetmap.org")
  }

  if (!"osmapir.base_auth_url" %in% names(op)) {
    options(osmapir.base_auth_url = "https://www.openstreetmap.org")
  }

  if (!"osmapir.oauth_id" %in% names(op)) {
    options(osmapir.oauth_id = "cxMGJjSNnEGiKHAdp0pGq54XtQPTSyuTOu-nVJ4P6FE")
  }

  if (!"osmapir.oauth_secret" %in% names(op)) {
    options(osmapir.oauth_secret = "L9o3QNmMC-rn8Hl6qcJrCpkty2QUCJPAWoiB2lIwawoZup_gfImaV9iUfGSZIeZSLP_s89qiFrbAH_Y")
  }

  if (!"osmapir.cache_authentication" %in% names(op)) {
    options(osmapir.cache_authentication = FALSE)
  }

  if (!"osmapir.api_version" %in% names(op)) {
    options(osmapir.api_version = "0.6")
  }

  invisible()
} # nocov end


.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Data (c) OpenStreetMap contributors, ODbL 1.0. https://www.openstreetmap.org/copyright")
}
