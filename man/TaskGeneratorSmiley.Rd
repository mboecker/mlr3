% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TaskGeneratorSmiley.R
\docType{data}
\name{TaskGeneratorSmiley}
\alias{TaskGeneratorSmiley}
\alias{mlr_task_generators_smiley}
\title{Smiley Classification Task Generator}
\format{\link[R6:R6Class]{R6::R6Class} inheriting from \link{TaskGenerator}.}
\usage{
TaskGeneratorSmiley
}
\description{
A \link{TaskGenerator} for the smiley task in \code{\link[mlbench:mlbench.smiley]{mlbench::mlbench.smiley()}}.
}
\examples{
mlr_task_generators$get("smiley")$generate(10)$data()
}
\keyword{datasets}