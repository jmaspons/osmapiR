% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osm_get_objects.R
\name{osm_get_objects}
\alias{osm_get_objects}
\title{Get OSM objects}
\usage{
osm_get_objects(
  osm_type,
  osm_id,
  version,
  full_objects = FALSE,
  format = c("R", "xml", "json"),
  tags_in_columns = FALSE
)
}
\arguments{
\item{osm_type}{A vector with the type of the objects (\code{"node"}, \code{"way"} or \code{"relation"}). Recycled if it has a
different length than \code{osm_id}.}

\item{osm_id}{Object ids represented by a numeric or a character vector.}

\item{version}{An optional vector with the version number for each object. If missing, the last version will be
retrieved. Recycled if it has different length than \code{osm_id}.}

\item{full_objects}{If \code{TRUE}, retrieves all other objects referenced by ways or relations. Not compatible with
\code{version}.}

\item{format}{Format of the output. Can be \code{"R"} (default), \code{"xml"}, or \code{"json"}.}

\item{tags_in_columns}{If \code{FALSE} (default), the tags of the objects are saved in a single list column \verb{tags``` containing a }data.frame\verb{for each OSM object with the keys and values. If}TRUE\verb{, add a column for each key. Ignored if }format != "R"`.}
}
\value{
If \code{format = "R"}, returns a data frame with one OSM object per row. If \code{format = "xml"}, returns a
\link[xml2:oldclass]{xml2::xml_document} following the
\href{https://wiki.openstreetmap.org/wiki/OSM_XML#OSM_XML_file_format_notes}{OSM_XML format}. If \code{format = "json"},
returns a list with a json structure following the \href{https://wiki.openstreetmap.org/wiki/OSM_JSON}{OSM_JSON format}.

Objects are sorted in the same order than \code{osm_id} except for \code{full_objects = TRUE}, where the nodes comes first,
then ways, and relations at the end as specified by
\href{https://wiki.openstreetmap.org/wiki/OSM_XML#OSM_XML_file_format_notes}{OSM_XML format}.
}
\description{
Retrieve objects by \code{type}, \code{id} and \code{version}.
}
\details{
\code{full_objects = TRUE} does not support specifying \code{version}.
For ways, \code{full_objects = TRUE} implies that it will return the way specified plus all nodes referenced by the way.
For a relation, it will return the following:
\itemize{
\item The relation itself
\item All nodes, ways, and relations that are members of the relation
\item Plus all nodes used by ways from the previous step
\item The same recursive logic is not applied to relations. This means: If relation r1 contains way w1 and relation r2,
and w1 contains nodes n1 and n2, and r2 contains node n3, then a "full" request for r1 will give you r1, r2, w1,
n1, and n2. Not n3.
}
}
\note{
For downloading data for purposes other than editing or exploring the history of the objects, perhaps is better to
use the Overpass API. A similar function to download OSM objects by \code{type} and \code{id} using Overpass, is implemented in
the \pkg{osmdata} function \code{opq_osm_id()}.
}
\examples{
obj <- osm_get_objects(
  osm_type = c("node", "way", "way", "relation", "relation", "node"),
  osm_id = c("35308286", "13073736", "235744929", "40581", "341530", "1935675367"),
  version = c(1, 3, 2, 5, 7, 1)
)
obj
}
\seealso{
Other get OSM objects' functions: 
\code{\link{osm_bbox_objects}()},
\code{\link{osm_history_object}()},
\code{\link{osm_relations_object}()},
\code{\link{osm_ways_node}()},
\code{\link{osmapi_objects}()}
}
\concept{get OSM objects' functions}
