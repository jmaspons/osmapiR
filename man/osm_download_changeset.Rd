% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osmapi_changesets.R
\name{osm_download_changeset}
\alias{osm_download_changeset}
\title{Download a changeset in \code{OsmChange} format}
\usage{
osm_download_changeset(changeset_id, format = c("R", "osc", "xml"))
}
\arguments{
\item{changeset_id}{The id of the changeset represented by a numeric or a character value for which the OsmChange is
requested.}

\item{format}{Format of the output. Can be \code{"R"} (default) or \code{"osc"} (\code{"xml"} is a synonym for \code{"osc"}).}
}
\value{
If \code{format = "R"}, returns a data frame with one row for each edit action in the changeset. If \code{format = "osc"},
returns a \link[xml2:oldclass]{xml2::xml_document} in the \href{https://wiki.openstreetmap.org/wiki/OsmChange}{OsmChange} format.
}
\description{
Returns the \href{https://wiki.openstreetmap.org/wiki/OsmChange}{OsmChange} document describing all changes associated with the changeset.
}
\details{
\itemize{
\item The result of calling this may change as long as the changeset is open.
\item The elements in the OsmChange are sorted by timestamp and version number.
\item There is \code{\link[=osm_get_changesets]{osm_get_changesets()}} to get only information about the changeset itself.
}
}
\examples{
chaset <- osm_download_changeset(changeset_id = 137003062)
chaset
}
\seealso{
Other get changesets' functions: 
\code{\link{osm_get_changesets}()},
\code{\link{osm_query_changesets}()}

Other OsmChange's functions: 
\code{\link{osm_diff_upload_changeset}()},
\code{\link{osmchange_create}()},
\code{\link{osmchange_delete}()},
\code{\link{osmchange_modify}()}
}
\concept{OsmChange's functions}
\concept{get changesets' functions}
