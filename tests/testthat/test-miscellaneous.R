## Available API versions: `GET /api/versions` ----

test_that("osm_api_versions works", {
  with_mock_dir("mock_api_versions", {
    api_versions <- osm_api_versions()
  })

  expect_type(api_versions, "character")
  expect_identical(api_versions, "0.6")
})


## Capabilities: `GET /api/capabilities` ----

test_that("osm_capabilities works", {
  with_mock_dir("mock_capabilities", {
    capabilities <- osm_capabilities()
  })

  expect_type(capabilities, "list")
})


## Retrieving map data by bounding box: `GET /api/0.6/map` ----

test_that("osm_bbox_objects works", {
  with_mock_dir("mock_bbox_objects", {
    bbox_objects <- osm_bbox_objects(bbox = c(1.8366775, 41.8336843, 1.8379971, 41.8344537))
  })
  # Warning message:
  # In (function (..., deparse.level = 1)  :
  #   number of columns of result is not a multiple of vector length (arg 1551)

  expect_s3_class(bbox_objects, "data.frame")
  obj_cols <- c("type", "id", "visible", "version", "changeset", "timestamp", "user", "uid", "lat", "lon", "members")
  expect_identical(names(bbox_objects)[seq_len(length(obj_cols))], obj_cols)
})


## Retrieving permissions: `GET /api/0.6/permissions` ----

test_that("osm_permissions works", {
  with_mock_dir("mock_permissions", {
    perms <- osm_permissions()
  })

  expect_type(perms, "character")
})