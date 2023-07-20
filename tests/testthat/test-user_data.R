column_users <- c(
  "id", "display_name", "account_created", "description", "img", "contributor_terms", "roles", "changesets_count",
  "traces_count", "blocks_received.count", "blocks_received.active", "blocks_issued.count", "blocks_issued.active"
)

class_columns <- list(
  id = "character", display_name = "character", account_created = "POSIXct", description = "character",
  img = "character", contributor_terms = "logical", roles = "character", changesets_count = "integer",
  traces_count = "integer", blocks_received.count = "integer", blocks_received.active = "integer",
  blocks_issued.count = "integer", blocks_issued.active = "integer"
)


## Details of a user: `GET /api/0.6/user/#id` ----

test_that("osm_details_user works", {
  with_mock_dir("mock_details_user", {
    usr <- osm_details_user(user_id = "11725140")
  })

  expect_s3_class(usr, "data.frame")
  expect_named(usr, column_users)

  mapply(function(x, cl) expect_true(inherits(x, cl)), x = usr, cl = class_columns[names(usr)])

  # Check that time is extracted, otherwise it's 00:00:00 in local time
  expect_false(strftime(as.POSIXct(usr$account_created), format = "%M:%S") == "00:00")
})


## Details of multiple users: `GET /api/0.6/users?users=#id1,#id2,...,#idn` ----

test_that("osm_details_users works", {
  usrs <- list()
  with_mock_dir("mock_details_users", {
    usrs$usrs <- osm_details_users(user_ids = c(1, 24, 44, 45, 46, 48, 49, 50))
    usrs$mod <- osm_details_users(user_ids = 61942)
  })

  lapply(usrs, expect_s3_class, "data.frame")
  lapply(usrs, function(x) expect_named(x, column_users))

  lapply(usrs, lapply, function(x) {
    mapply(function(y, cl) expect_true(inherits(y, cl)), y = x, cl = class_columns[names(x)])
  })

  # Check that time is extracted, otherwise it's 00:00:00 in local time
  lapply(usrs, function(x) expect_false(all(strftime(as.POSIXct(x$account_created), format = "%M:%S") == "00:00")))
})


## Details of the logged-in user: `GET /api/0.6/user/details` ----

test_that("osm_details_logged_user works", {
  with_mock_dir("mock_details_logged_user", {
    usr_details <- osm_details_logged_user()
  })

  expect_type(usr_details, "list")
  expect_named(
    usr_details,
    c(
      "user", "description", "img", "contributor_terms", "roles",
      "changesets", "traces", "blocks", "home", "languages", "messages"
    )
  )
})


## Preferences of the logged-in user: `GET /api/0.6/user/preferences` ----

#  PUT /api/0.6/user/preferences
#
# The same structure in the body of the a PUT will upload preferences. All existing preferences are replaced by the newly uploaded set.
#
#  GET /api/0.6/user/preferences/[your_key] (without the brackets)
#
# Returns a string with that preference's value.
#
#  PUT /api/0.6/user/preferences/[your_key] (without the brackets)
#
# Will set a single preference's value to a string passed as the content of the request.
#
#  PUT /api/0.6/user/preferences/[your_key]
#
# in this instance, the payload of the request should only contain the value of the preference, i.e. not XML formatted.
#
# The PUT call returns HTTP response code 406 (not acceptable) if the same key occurs more than once, and code 413 (request entity too large) if you try to upload more than 150 preferences at once. The sizes of the key and value are limited to 255 characters.
#
# A single preference entry can be deleted with
#
#  DELETE /api/0.6/user/preferences/[your_key]

test_that("osm_get_preferences_user works", {
  with_mock_dir("mock_preferences_user", {
    preferences <- osm_get_preferences_user()
  })

  expect_s3_class(preferences, "data.frame")
  expect_named(preferences, c("key", "value"))
})