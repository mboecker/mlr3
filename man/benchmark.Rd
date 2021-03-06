% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/benchmark.R
\name{benchmark}
\alias{benchmark}
\title{Benchmark Multiple Learners on Multiple Tasks}
\usage{
benchmark(design, store_models = FALSE)
}
\arguments{
\item{design}{:: \code{\link[=data.frame]{data.frame()}}\cr
Data frame (or \code{\link[data.table:data.table]{data.table::data.table()}}) with three columns: "task", "learner", and "resampling".
Each row defines a resampling by providing a \link{Task}, \link{Learner} and an instantiated \link{Resampling} strategy.
The helper function \code{\link[=benchmark_grid]{benchmark_grid()}} can assist in generating an exhaustive design (see examples) and
instantiate the \link{Resampling}s per \link{Task}.}

\item{store_models}{:: \code{logical(1)}\cr
Keep the fitted model after the test set has been predicted?
Set to \code{TRUE} if you want to further analyse the models or want to
extract information like variable importance.}
}
\value{
\link{BenchmarkResult}.
}
\description{
Runs a benchmark on arbitrary combinations of tasks (\link{Task}), learners (\link{Learner}), and resampling strategies (\link{Resampling}), possibly in parallel.
}
\note{
The fitted models are discarded after the predictions have been scored in order to reduce memory consumption.
If you need access to the models for later analysis, set \code{store_models} to \code{TRUE}.
}
\section{Parallelization}{


This function can be parallelized with the \CRANpkg{future} package.
One job is one resampling iteration, and all jobs are send to an apply function
from \CRANpkg{future.apply} in a single batch.
To select a parallel backend, use \code{\link[future:plan]{future::plan()}}.
}

\section{Logging}{


The \CRANpkg{mlr3} uses the \CRANpkg{lgr} package for logging.
\CRANpkg{lgr} supports multiple log levels which can be queried with
\code{getOption("lgr.log_levels")}.

To suppress output and reduce verbosity, you can lower the log from the
default level \code{"info"} to \code{"warn"}:\preformatted{lgr::get_logger("mlr3")$set_threshold("warn")
}

To get additional log output for debugging, increase the log level to \code{"debug"}
or \code{"trace"}:\preformatted{lgr::get_logger("mlr3")$set_threshold("debug")
}

To log to a file or a data base, see the documentation of \link[lgr:lgr-package]{lgr::lgr-package}.
}

\examples{
# benchmarking with benchmark_grid()
tasks = lapply(c("iris", "sonar"), tsk)
learners = lapply(c("classif.featureless", "classif.rpart"), lrn)
resamplings = rsmp("cv", folds = 3)

design = benchmark_grid(tasks, learners, resamplings)
print(design)

set.seed(123)
bmr = benchmark(design)

## data of all resamplings
head(as.data.table(bmr))

## aggregated performance values
aggr = bmr$aggregate()
print(aggr)

## Extract predictions of first resampling result
rr = aggr$resample_result[[1]]
as.data.table(rr$prediction())

# benchmarking with a custom design:
# - fit classif.featureless on iris with a 3-fold CV
# - fit classif.rpart on sonar using a holdout
tasks = list(tsk("iris"), tsk("sonar"))
learners = list(lrn("classif.featureless"), lrn("classif.rpart"))
resamplings = list(rsmp("cv", folds = 3), rsmp("holdout"))

design = data.table::data.table(
  task = tasks,
  learner = learners,
  resampling = resamplings
)

## instantiate resamplings
design$resampling = Map(
  function(task, resampling) resampling$clone()$instantiate(task),
  task = design$task, resampling = design$resampling
)

## run benchmark
bmr = benchmark(design)
print(bmr)

## get the training set of the 2nd iteration of the featureless learner on iris
rr = bmr$aggregate()[learner_id == "classif.featureless"]$resample_result[[1]]
rr$resampling$train_set(2)
}
