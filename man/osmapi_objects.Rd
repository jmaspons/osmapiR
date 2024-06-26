% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osmapiR_objects.R
\name{osmapi_objects}
\alias{osmapi_objects}
\title{osmapi_objects constructor}
\usage{
osmapi_objects(x, tag_columns, keep_na_tags = FALSE)
}
\arguments{
\item{x}{\code{data.frame} representing OSM objects as rows. At least it has a \code{type} column with \code{node}, \code{way} or
\code{relation}.}

\item{tag_columns}{A vector indicating the name or position of the columns representing tags. If missing, it's
assumed that \code{tags} column contain the tags (see details).}

\item{keep_na_tags}{If \code{TRUE}, don't drop the empty tags specified in \code{tag_columns} and add \code{NA} as a value.
Useful to remove specific tags with \code{\link[=osmchange_modify]{osmchange_modify()}} and specific \code{tag_keys}.}
}
\value{
An \code{osmapi_objects}
}
\description{
osmapi_objects constructor
}
\examples{
x <- data.frame(
  type = c("node", "node", "way"), id = 1:3, name = c(NA, NA, "My way")
)
x$members <- list(NULL, NULL, 1:2)
obj <- osmapi_objects(x, tag_columns = "name")
obj
}
\seealso{
Other get OSM objects' functions: 
\code{\link{osm_bbox_objects}()},
\code{\link{osm_get_objects}()},
\code{\link{osm_history_object}()},
\code{\link{osm_relations_object}()},
\code{\link{osm_ways_node}()}
}
\concept{get OSM objects' functions}
