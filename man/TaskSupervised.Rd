% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TaskSupervised.R
\docType{data}
\name{TaskSupervised}
\alias{TaskSupervised}
\title{Supervised Task}
\format{\link[R6:R6Class]{R6::R6Class} object inheriting from \link{Task}.}
\description{
This is the abstract base class for task objects like \link{TaskClassif} and \link{TaskRegr}.
It extends \link{Task} with methods to handle a target columns.
}
\section{Construction}{
\preformatted{t = TaskSupervised$new(id, task_type, backend, target)
}
\itemize{
\item \code{id} :: \code{character(1)}\cr
Identifier for the task.
\item \code{backend} :: \link{DataBackend}\cr
Either a \link{DataBackend}, or any object which is convertible to a DataBackend with \code{as_data_backend()}.
E.g., a \code{data.frame()} will be converted to a \link{DataBackendDataTable}.
\item \code{task_type} :: \code{character(1)}\cr
Set in the classes which inherit from this class.
Must be an element of \link[=mlr_reflections]{mlr_reflections$task_types$type}.
\item \code{target} :: \code{character(1)}\cr
Name of the target column.
}
}

\section{Fields}{

See \link{Task}.
}

\section{Methods}{

All methods from \link{Task}, and additionally:
\itemize{
\item \code{truth(row_ids = NULL)} :: \code{any}\cr
True response for specified \code{row_ids}. Format depends on the task type.
Defaults to all rows with role "use".
}
}

\examples{
task = TaskSupervised$new("iris", task_type = "classif", backend = iris, target = "Species")
}
\seealso{
Other Task: \code{\link{TaskClassif}},
  \code{\link{TaskRegr}}, \code{\link{Task}},
  \code{\link{mlr_tasks}}
}
\concept{Task}
\keyword{internal}
