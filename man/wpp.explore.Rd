\name{wpp.explore}
\alias{wpp.explore}

\title{
Launching Explorer
}
\description{
Main function of the package. It opens an interactive (shiny) interface in a browser. To exit the browser view, hit the Escape key.
}
\usage{
wpp.explore(wpp.year = 2015, host = NULL, sim.dir = NULL, ...)
}

\arguments{
  \item{wpp.year}{Determines which \pkg{wpp} package is to be explored. Currently only 2015 available. Data on migration and population is loaded from the \pkg{wpp2015BayesMig} package, remaining datasets are loaded from the \pkg{wpp2015} package.}
  \item{host}{Argument passed to \code{\link[shiny:runApp]{runApp}}. Defaults to the \code{shiny.host} option, or \code{"0.0.0.0"} if not set.}
  \item{sim.dir}{Simulation directory used for probability calculations. It should be a directory created by the \link[bayesPop:pop.predict]{pop.predict} function of the \pkg{bayesPop} package.}
  \item{\dots}{Additional arguments passed to \code{\link[shiny:runApp]{runApp}}.}
}
\details{
	The time slider in the left pane defines the year or time period for which data are shown. Note that for vital rates indicators, such as fertility, mortality, migration and sex ratio at birth, the time shown on the slider is the end year of the time period of the data shown in the right pane.
	
	The uncertainty selection is only used for indicators and years for which the corresponding lower and upper bounds are available, and for the appropriate visualization types. These are country plots that appear after clicking on the map, table in the \dQuote{Sortable Data} tab, and \dQuote{Trends} and \dQuote{Pyramids}.  
	
	The ggplot-based graphs in the Trends and Pyramids tabs are interactive. One can see the data values by mouse hovering or single clicks. One can zoom in by selecting a region. Zooming out is done by a double click.  
	
	For more information see the Help tab of the explorer.
	%The interface can be accessed online: \url{https://rstudio.stat.washington.edu/shiny/wppExplorer/inst/explore/}
}
%\value{
%}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
Hana Sevcikova, based on code from a Joe Cheng's shiny example. Used comments from Patrick Gerland.
}
\note{
If you have any troubles to see the data, please check that the \pkg{\link[shiny:shiny-package]{shiny}} package is working in your environment. In particular, check that examples in \url{http://rstudio.github.com/shiny/tutorial} work. On Windows, you might check this:
\url{https://groups.google.com/forum/#!topic/shiny-discuss/tqeURyiPmFI}
}

\seealso{
\code{\link[wpp2015BayesMig:wpp2015BayesMig-package]{wpp2015BayesMig}}, \code{\link{wpp.indicator}}
}
\examples{
\dontrun{
wpp.explore()}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ programming }

