# osmapiR (development version)

* Upgrade logo by @atarom
* Add inst/CITATION
* Improve tests and fix bugs (#35, 08fb4b10abf0270d8bea2473b02b2520ba341521)
* Add format = "sf" for functions returning objects of class `osmapi_map_notes` (#36)
* Add format = "sf" for functions returning objects of class `osmapi_changesets` (#37)
* Add format = "sf" for functions returning objects of class `osmapi_gpx_metadata` (#38)
* Updated links to the new osmapiR home at rOpenSci (#40)

# osmapiR 0.1.0

* Initial CRAN submission implementing calls to all the API endpoints.
* Server responses are returned as R objects, xml_documents or json lists.
* Authentication when needed with OAuth2.
* Pagination in server responses handled internally (#20, #23 & #29).
* Vectorization of atomic API calls (#18).
