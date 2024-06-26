% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osmapi_miscellaneous.R
\name{osm_capabilities}
\alias{osm_capabilities}
\title{Capabilities of the API}
\usage{
osm_capabilities()
}
\value{
A list with the API capabilities and policies.
}
\description{
Provide information about the capabilities and limitations of the current API.
}
\details{
API:
\itemize{
\item \code{version} \code{minimum} and \code{maximum} are the API call versions that the server will accept.
\item \code{area} \code{maximum} is the maximum area in square degrees that can be queried by API calls.
\item \code{tracepoints} \code{per_page} is the maximum number of points in a single GPS trace. (Possibly incorrect)
\item \code{waynodes} \code{maximum} is the maximum number of nodes that a way may contain.
\item \code{relationmember} \code{maximum} is the maximum number of members that a relation may contain.
\item \code{changesets} \code{maximum_elements} is the maximum number of combined nodes, ways and relations that can be contained
in a changeset.
\item \code{changesets} \code{default_query_limit} and \code{maximum_query_limit} are the default and maximum values of the limit
parameter of \code{\link[=osm_query_changesets]{osm_query_changesets()}}.
\item \code{notes} \code{default_query_limit} and \code{maximum_query_limit} are the default and maximum values of the limit parameter
of notes bounding box queries (\code{\link[=osm_read_bbox_notes]{osm_read_bbox_notes()}}) and search (\code{\link[=osm_search_notes]{osm_search_notes()}}).
\item The \code{status} element returns either \emph{online}, \emph{readonly} or \emph{offline} for each of the database, API and GPX
API. The \code{database} field is informational, and the \code{API}/\code{GPX-API} fields indicate whether a client should expect
read and write requests to work (\emph{online}), only read requests to work (\emph{readonly}) or no requests to work
(\emph{offline}).
}

Policy:
\itemize{
\item Imagery blacklist lists all aerial and map sources, which are not permitted for OSM usage due to copyright. Editors
must not show these resources as background layer.
}
}
\examples{
osm_capabilities()
}
\seealso{
Other API functions: 
\code{\link{authenticate_osmapi}()},
\code{\link{osm_api_versions}()},
\code{\link{osm_permissions}()},
\code{\link{set_osmapi_connection}()}
}
\concept{API functions}
