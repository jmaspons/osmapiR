column_meta_gpx <- c(
  "id", "name", "uid", "user", "visibility", "pending", "timestamp", "lat", "lon", "description", "tags"
)
column_gpx <- c("lat", "lon", "ele", "time")
column_pts_gps <- c("lat", "lon", "time")

class_columns <- list(
  id = "character", name = "character", uid = "character", user = "character", visibility = "character",
  pending = "logical", timestamp = "POSIXct", lat = "character", lon = "character", description = "character",
  tags = "list", ele = "character", time = "POSIXct"
)


## Get GPS Points: `GET /api/0.6/trackpoints?bbox=*'left','bottom','right','top'*&page=*'pageNumber'*` ----

test_that("osm_get_points_gps works", {
  pts_gps <- list()
  with_mock_dir("mock_get_points_gps", {
    pts_gps$private <- osm_get_points_gps(bbox = c(-0.4789191, 38.1662652, -0.4778007, 38.1677898))
    pts_gps$public <- osm_get_points_gps(bbox = c(-0.6430006, 38.1073445, -0.6347179, 38.1112953))
  })

  lapply(pts_gps, expect_type, "list")
  lapply(pts_gps, expect_s3_class, "osmapi_gpx")
  lapply(pts_gps$private, expect_named, setdiff(column_pts_gps, "time"))
  lapply(pts_gps$public, expect_named, column_pts_gps)

  lapply(pts_gps, lapply, function(x) {
    mapply(function(y, cl) expect_true(inherits(y, cl)), y = x, cl = class_columns[names(x)])
  })

  # Check that time is extracted, otherwise it's 00:00:00 in local time
  lapply(pts_gps$public, function(x) expect_false(unique(strftime(as.POSIXct(x$time), format = "%M:%S") == "00:00")))

  # methods
  summary_gpx <- lapply(pts_gps, summary)
  lapply(summary_gpx, expect_s3_class, "data.frame")


  ## Empty results

  with_mock_dir("mock_get_points_gps_empty", {
    empty_pts_gps <- osm_get_points_gps(bbox = c(-105, -7, -104.9, -6.9))
  })

  expect_type(empty_pts_gps, "list")
  expect_s3_class(empty_pts_gps, "osmapi_gpx")
  expect_length(empty_pts_gps, 0)

  # methods
  summary_gpx <- summary(empty_pts_gps)
  expect_s3_class(summary_gpx, "data.frame")
})




test_that("edit gpx works", {
  gpx_path <- test_path("sample_files", "sample.gpx")

  ## Create: `POST /api/0.6/gpx/create` ----
  # with_mock_dir("mock_create_gpx", { # TODO: fails with mock dir
  # create_trace <- osm_create_gpx(
  #   file = gpx_path,
  #   description = "Test create gpx with osmapiR.",
  #   tags = c("testing", "osmapiR")
  # )
  # })

  # expect_type(create_trace, "character")

  ## Update: `PUT /api/0.6/gpx/#id` ----

  # with_mock_dir("mock_update_gpx", {
  #   upd_trace <- osm_update_gpx(gpx_id = create_trace, file = gpx_path)
  # TODO: HTTP 502 Bad Gateway.
  # })

  ## Delete: `DELETE /api/0.6/gpx/#id` ----

  # expect_DELETE(
  # del_trace <- osm_delete_gpx(gpx_id = create_trace)
  # )

  # expect_null(del_trace)
})


## Download Metadata: `GET /api/0.6/gpx/#id/details` ----

test_that("osm_get_metadata_gpx works", {
  trk_meta <- list()
  with_mock_dir("mock_get_metadata_gpx", {
    trk_meta$track <- osm_get_gpx_metadata(gpx_id = 3790367)
    trk_meta$tracks <- osm_get_gpx_metadata(gpx_id = c(3790367, 3458743))
    trk_meta$track_xml <- osm_get_gpx_metadata(gpx_id = 3790367, format = "xml")
    trk_meta$tracks_xml <- osm_get_gpx_metadata(gpx_id = c(3790367, 3458743), format = "xml")
  })

  lapply(trk_meta[c("track", "tracks")], function(x) expect_s3_class(x, "data.frame"))
  lapply(trk_meta[c("track", "tracks")], function(x) expect_named(x, column_meta_gpx))

  lapply(trk_meta[c("track", "tracks")], function(trk) {
    mapply(function(x, cl) expect_true(inherits(x, cl)), x = trk, cl = class_columns[names(trk)])
  })

  # Check that time is extracted, otherwise it's 00:00:00 in local time
  lapply(trk_meta[c("track", "tracks")], function(x) {
    expect_false(unique(strftime(as.POSIXct(x$timestamp), format = "%M:%S") == "00:00"))
  })

  lapply(trk_meta[c("track_xml", "tracks_xml")], expect_s3_class, class = "xml_document")
})


## Download Data: `GET /api/0.6/gpx/#id/data` ----

#' @param format Format of the output. If missing (default), the response will be the exact file that was uploaded.
#'   If `R`, a `data.frame`.
#'   If `gpx`, the response will always be a GPX format file.
#'   If `xml`, a `XML` file in an undocumented format.
test_that("osm_get_data_gpx works", {
  trk_data <- list()
  with_mock_dir("mock_get_data_gpx", {
    trk_data$raw <- osm_get_data_gpx(gpx_id = 3458743)
    trk_data$gpx <- osm_get_data_gpx(gpx_id = 3458743, format = "gpx") # identical to xml resp but heavier mock file
    ## gpx responses has `content-type` = "application/gpx+xml and httptest2 save them as raw instead of xml files
    trk_data$xml <- osm_get_data_gpx(gpx_id = 3458743, format = "xml")
    trk_data$R <- osm_get_data_gpx(gpx_id = 3458743, format = "R")
  })

  lapply(trk_data[c("raw", "gpx", "xml")], expect_s3_class, class = "xml_document")

  expect_s3_class(trk_data$R, c("osmapi_gps_track", "data.frame"))
  expect_named(trk_data$R, column_gpx)

  mapply(function(x, cl) expect_true(inherits(x, cl)), x = trk_data$R, cl = class_columns[names(trk_data$R)])

  # Check that time is extracted, otherwise it's 00:00:00 in local time
  expect_false(all(strftime(as.POSIXct(trk_data$R$time), format = "%M:%S") == "00:00"))
})


## List: `GET /api/0.6/user/gpx_files` ----

test_that("osm_list_gpxs works", {
  with_mock_dir("mock_list_gpxs", {
    traces <- osm_list_gpxs()
  })

  expect_s3_class(traces, "data.frame")
  expect_named(traces, column_meta_gpx)
})
