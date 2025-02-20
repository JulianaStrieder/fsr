% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fsi_functions.R
\name{fsi_qw_eval}
\alias{fsi_qw_eval}
\title{Evaluating a query window inference}
\usage{
fsi_qw_eval(fsi, qw, approach = "discretization", ...)
}
\arguments{
\item{fsi}{An FSI model built with the \code{fsi_create} function that is populated by the following functions \code{fsi_add_fsa}, \code{fsi_add_cs}, and \code{fsi_add_rules}.}

\item{qw}{An \code{sfg} object storing the query window that is supposed to be used as input for the inference. It has to be an axis-aligned rectangle represented by a simple polygon object of 5 points (since the last coordinate pair closes the external ring of the rectangle).}

\item{approach}{Defines which approach is employed to perform the query window inference: \verb{“discretization”} or \verb{“pso”}. Default value is `"discretization"``}

\item{...}{<\code{\link[rlang:dyn-dots]{dynamic-dots}}> Different set of parameters required depending on the chosen approach (see more in details below).}
}
\value{
A tibble in the format \verb{(points, inferred_values)}, where \code{points} is an \code{sfc} object (i.e., a list of \code{sfg} objects of geometry type POINT) and \code{inferred_values} are inferred values in the domain of the consequent of the FSI model.
}
\description{
This function implements two approaches for evaluating the query window inference on a fuzzy spatial inference (FSI) model.
Given a query window (i.e., a rectangular object), it returns a set of inferred points inside this window
that satisfy a specific condition (e.g., target linguistic value, or maximum/minimum inferred values).
}
\details{
For the \emph{discretization} approach, two additional parameters are needed and they have to be informed by using the three-dots parameter \code{...}:
\itemize{
\item \code{target_lval}: A character value that indicates the target linguistic value from the linguistic variable of the consequent.
\item \code{k}: A numeric value that defines the number of points that will be captured from the query window and evaluated by the function \code{fsi_eval}. Its square root has to an integer value.   Alternatively, you can inform the number of columns and rows of the regular grid to be performed on the query window by informing numeric values for \code{n_col} and \code{n_row}, respectively. Thus, these parameters can be given instead of the number \code{k}.
}

For the \emph{pso} approach, it is necessary to set the following parameters:
\itemize{
\item \code{what}: A character value that defines the user's goal, which can be either \strong{maximize} or \strong{minimize} inferred values. Thus, this parameter can be \verb{“max”} and \verb{“min”}, respectively. The default value is \verb{“max”}.
\item \code{max_depth}: A numeric value that refers to the number of times the user wants to split the query window. The default value is equal to 2. For instance, a \code{max_depth} = 2 results in the query window split into four sub quadrants, where the particle swarm optimization (PSO) algorithm will be applied to each one as its search space.
In addition, the PSO algorithm has its own set of parameters:
\item \code{maxit}: A numeric value that defines the maximum number of iterations. Default value is 50.
\item \code{population}: A numeric value that defines the number of particles. Default value is 10.
}
}
\examples{

library(sf)
# Creating the FSI model from an example implemented with the visitation function:
fsi <- visitation()

# Creating a vector of fuzzy rules; 
## note that we make use of the linguistic variables and linguistic values previously defined:
rules <- c(
  "IF accommodation review is reasonable AND food safety is low 
  THEN visiting experience is awful",
 "IF accommodation price is expensive AND accommodation review is reasonable 
   THEN visiting experience is awful",
 "IF accommodation price is affordable AND accommodation review is good AND food safety is medium 
   THEN visiting experience is average",
 "IF accommodation price is affordable AND accommodation review is excellent 
                                                                AND food safety is high 
   THEN visiting experience is great",
 "IF accommodation price is cut-rate AND accommodation review is excellent AND food safety is high 
   THEN visiting experience is great")

# Adding these rules to the FSI model previously instantiated:
fsi <- fsi_add_rules(fsi, rules)

# Defining the query window that is defined over an application domain
pts_qw1 <- rbind(c(-73.92, 40.68527), c(-73.75, 40.68527), 
                 c(-73.75, 40.75), c(-73.92, 40.75), c(-73.92, 40.68527))
qw1 <- st_polygon(list(pts_qw1))

# Example using the discretization approach:
dis_res <- fsi_qw_eval(fsi, qw1, approach = "discretization", target_lval = "great", k = 25)

# Example using the pso approach in one level only:
pso_res <- fsi_qw_eval(fsi, qw1, approach = "pso", max_depth = 1)

}
