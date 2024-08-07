% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osmchange.R
\name{osmchange_modify}
\alias{osmchange_modify}
\title{\code{osmchange} to modify existing OSM objects}
\usage{
osmchange_modify(
  x,
  tag_keys,
  members = FALSE,
  lat_lon = FALSE,
  format = c("R", "osc", "xml")
)
}
\arguments{
\item{x}{A \link{osmapi_objects} with the columns \code{type} and \code{id} with unique combinations of values plus columns
specifying tags, members or latitude and longitude.}

\item{tag_keys}{A character vector with the keys of the tags that will be modified. If missing (default),
all tags will be updated, removed or created. If \code{FALSE}, don't modify tags.}

\item{members}{If \code{TRUE} and \code{x} has a \code{members} column, update the members of the ways and relations objects.}

\item{lat_lon}{If \code{TRUE} and \code{x} has a \code{lat} and \code{lon} columns, update the coordinates of the node objects.}

\item{format}{Format of the output. Can be \code{"R"} (default), \code{"osc"} (\code{"xml"} is a synonym for \code{"osc"}).}
}
\value{
If \code{format = "R"}, returns a \code{osmapi_OsmChange} data frame with one OSM edition per row.
If \code{format = "osc"} or \code{format = "xml"}, returns a \link[xml2:oldclass]{xml2::xml_document} following the
\href{https://wiki.openstreetmap.org/wiki/OsmChange}{OsmChange format} that can be saved with \code{\link[xml2:write_xml]{xml2::write_xml()}} and
opened in other applications such as JOSM.

The results are  ready to send the editions to the servers with \code{\link[=osm_diff_upload_changeset]{osm_diff_upload_changeset()}}.
}
\description{
Prepare data to update tags, members and/or latitude and longitude.
}
\details{
\code{x} should be a \code{osmapi_objects} or follow the same format. Missing tags or tags with \code{NA} in the value will be
removed if \code{tag_keys} is not specified. See \code{\link[=osm_get_objects]{osm_get_objects()}} for examples of the format.
}
\examples{
obj <- osm_get_objects(
  osm_type = c("node", "way", "way", "relation", "relation", "node"),
  osm_id = c("35308286", "13073736", "235744929", "40581", "341530", "1935675367"),
  version = c(1, 3, 2, 5, 7, 1) # Old versions
)
osmch <- osmchange_modify(obj)
osmch
}
\seealso{
Other OsmChange's functions: 
\code{\link{osm_diff_upload_changeset}()},
\code{\link{osm_download_changeset}()},
\code{\link{osmchange_create}()},
\code{\link{osmchange_delete}()}
}
\concept{OsmChange's functions}
