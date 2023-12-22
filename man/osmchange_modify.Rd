% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osmchange.R
\name{osmchange_modify}
\alias{osmchange_modify}
\title{Modify existing OSM objects}
\usage{
osmchange_modify(x, tag_keys, members = FALSE, lat_lon = FALSE)
}
\arguments{
\item{x}{A \code{data.frame} with the columns \code{type} and \code{id} with unique combinations of values plus columns specifying
tags, members or latitude and longitude.}

\item{tag_keys}{A character vector with the keys of the tags that will be modified. If missing (default),
all tags will be updated, removed or created (doesn't work for \code{x} with tags in a wide format). If \code{FALSE}, don't
modify tags.}

\item{members}{If \code{TRUE} and \code{x} has a \code{members} column, update the members of the ways and relations objects.}

\item{lat_lon}{If \code{TRUE} and \code{x} has a \code{lat} and \code{lon} columns, update the coordinates of the node objects.}
}
\description{
Update tags, members and/or latitude and longitude.
}
\details{
\code{x} should follow the format of \code{osmapi_objects} with tags in wide format or a \code{tags} column with a list of
data.frames with \code{key} and \code{value} columns. Missing tags or tags with \code{NA} in the value will be removed. See
\code{\link[=osm_get_objects]{osm_get_objects()}} for examples of the format.
}
\seealso{
Other OsmChange's functions: 
\code{\link{osm_diff_upload_changeset}()},
\code{\link{osm_download_changeset}()},
\code{\link{osmchange_create}()},
\code{\link{osmchange_delete}()}
}
\concept{OsmChange's functions}