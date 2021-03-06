% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/GetFundamentals.R
\name{GetFundamentals}
\alias{GetFundamentals}
\title{GetFundamentals}
\usage{
GetFundamentals(firm.name, fundamentals.codes, sheets, dates = NULL)
}
\arguments{
\item{firm.name}{Name of firm}

\item{sheets}{A list of T1 sheets}

\item{dates}{(optional) A character vector of reporting dates. These can either be years (e.g. '2014') or specific dates (e.g. '2014-05-12).}

\item{fundamentals.names}{A character vector of fundamentals}
}
\value{
A matrix of fundamentals (one per column)
}
\description{
Extracts a set of fundamentals for a given firm across a number of reporting periods.
}

