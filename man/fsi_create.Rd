% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fsi_functions.R
\name{fsi_create}
\alias{fsi_create}
\title{Creation of an empty fuzzy spatial inference model}
\usage{
fsi_create(name, and_method = "min", or_method = "max",
           imp_method = "min", agg_method = "max", 
           defuzz_method = "centroid", default_conseq = NULL)
}
\arguments{
\item{name}{A character value that specifies the name of the FSI model.}

\item{and_method}{A character value that defines the operator name for the logical connective AND. Default value is \code{"min"}.}

\item{or_method}{A character value that defines the operator for the logical connective OR. Default value is \code{"max"}.}

\item{imp_method}{A character value that defines the operator for the implication operator. Default value is \code{"min"}.}

\item{agg_method}{A character value that defines the operator for the aggregation operator. Default value is \code{"max"}.}

\item{defuzz_method}{A character value that determines the defuzzification technique. Default value is the centroid technique.}

\item{default_conseq}{This parameter is a membership function generated by the function \code{genmf} of the FuzzyR package.}
}
\value{
An empty named FSI model that is ready to be populated with fuzzy rules representing the antecedents and the consequent.
}
\description{
This function builds a fuzzy spatial inference (FSI) model without elements of the data source component (i.e., spatial plateau objects, fuzzy rules set, and fuzzy sets).
}
\details{
The FSI model created with the function \code{fsi_create} and its default parameter values will implement a model using Mamdani's method.
The possible values for the parameters \code{and_method} and \code{imp_method} are: \code{"min"}, \code{"prod"}. Other t-norms from the FuzzyR package are also conceivable.
The possible value for the parameters \code{or_method} and \code{agg_method} is: \code{"max"}. Other t-conorms from the FuzzyR package are also conceivable.
The possible values for the parameter \code{defuzz_method} include other defuzzification techniques from the FuzzyR package.
The parameter \code{default_conseq} defines the default behavior of the FSI model when there is no fuzzy rule with a degree of fulfillment greater than 0 returned by the FSI model.

After creating an empty FSI model, you have to call the functions \code{fsi_add_fsa}, \code{fsi_add_cs}, and \code{fsi_add_rules} to fulfill the FSI model.
}
\examples{

library(FuzzyR)
# Creating the FSI model
fsi <- fsi_create("To visit or not to visit, that is the question", 
                  default_conseq = genmf("trimf", c(10, 30, 60))) 

}
