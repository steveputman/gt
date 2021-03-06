% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/modify_columns.R
\name{cols_hide}
\alias{cols_hide}
\title{Hide one or more columns}
\usage{
cols_hide(data, columns)
}
\arguments{
\item{data}{A table object that is created using the \code{\link[=gt]{gt()}} function.}

\item{columns}{The column names to hide from the output display table. Values
provided that do not correspond to column names will be disregarded.}
}
\value{
An object of class \code{gt_tbl}.
}
\description{
The \code{cols_hide()} function allows us to hide one or more columns from
appearing in the final output table. While it's possible and often desirable
to omit columns from the input table data before introduction to the \code{\link[=gt]{gt()}}
function, there can be cases where the data in certain columns is useful (as
a column reference during formatting of other columns) but the final display
of those columns is not necessary.
}
\details{
The hiding of columns is internally a rendering directive, so, all columns
that are 'hidden' are still accessible and useful in any expression provided
to a \code{rows} argument. Furthermore, the \code{cols_hide()} function (as with many
\strong{gt} functions) can be placed anywhere in a pipeline of \strong{gt} function
calls (acting as a promise to hide columns when the timing is right). However
there's perhaps greater readability when placing this call closer to the end
of such a pipeline. The \code{cols_hide()} function quietly changes the visible
state of a column (much like the \code{\link[=cols_unhide]{cols_unhide()}} function) and doesn't yield
warnings or messages when changing the state of already-invisible columns.
}
\section{Figures}{

\if{html}{\figure{man_cols_hide_1.png}{options: width=100\%}}

\if{html}{\figure{man_cols_hide_2.png}{options: width=100\%}}
}

\section{Function ID}{

4-7
}

\examples{
# Use `countrypops` to create a gt table;
# Hide the columns `country_code_2` and
# `country_code_3`
tab_1 <-
  countrypops \%>\%
  dplyr::filter(country_name == "Mongolia") \%>\%
  tail(5) \%>\%
  gt() \%>\%
  cols_hide(
    columns = c(
      country_code_2, country_code_3
    )
  )

# Use `countrypops` to create a gt table;
# Use the `population` column to provide
# the conditional placement of footnotes,
# then hide that column and one other
tab_2 <-
  countrypops \%>\%
  dplyr::filter(country_name == "Mongolia") \%>\%
  tail(5) \%>\%
  gt() \%>\%
  cols_hide(
    columns = c(country_code_3, population)
  ) \%>\%
  tab_footnote(
    footnote = "Population above 3,000,000.",
    locations = cells_body(
      columns = year,
      rows = population > 3000000
    )
  )

}
\seealso{
\code{\link[=cols_unhide]{cols_unhide()}} to perform the inverse operation.

Other Modify Columns: 
\code{\link{cols_align}()},
\code{\link{cols_label}()},
\code{\link{cols_merge_n_pct}()},
\code{\link{cols_merge_range}()},
\code{\link{cols_merge_uncert}()},
\code{\link{cols_merge}()},
\code{\link{cols_move_to_end}()},
\code{\link{cols_move_to_start}()},
\code{\link{cols_move}()},
\code{\link{cols_unhide}()},
\code{\link{cols_width}()}
}
\concept{Modify Columns}
