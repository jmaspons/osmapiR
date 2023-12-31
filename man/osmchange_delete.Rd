% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osmchange.R
\name{osmchange_delete}
\alias{osmchange_delete}
\title{Delete existing OSM objects}
\usage{
osmchange_delete(x, delete_if_unused = TRUE)
}
\arguments{
\item{x}{A \code{data.frame} with the columns \code{type} and \code{id}.}

\item{delete_if_unused}{If \code{TRUE} (default), the \verb{if-unused} attribute will be added. Can be a vector of length
\code{nrow(x)}.}
}
\description{
Delete existing OSM objects
}
\details{
If \verb{if-unused} attribute is present, then the delete operation(s) in this block are conditional and will only be
executed if the object to be deleted is not used by another object. Without the \verb{if-unused}, such a situation would
lead to an error, and the whole diff upload would fail. Setting the attribute will also cause deletions of already
deleted objects to not generate an error.
}
\seealso{
Other OsmChange's functions: 
\code{\link{osm_diff_upload_changeset}()},
\code{\link{osm_download_changeset}()},
\code{\link{osmchange_create}()},
\code{\link{osmchange_modify}()}
}
\concept{OsmChange's functions}
