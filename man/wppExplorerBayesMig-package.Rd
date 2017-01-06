\name{wppExplorerBayesMig-package}
\alias{wppExplorerBayesMig-package}
\alias{wppExplorerBayesMig}
\docType{package}
\title{
Explorer of the World Population Prospects with Migration Uncertainty
}

\description{
	This is a modified version of the \pkg{wppExplorer} package that allows you to interactively explore probabilistic population projections with migration uncertainty produced using the method by Azose et al. (2016)  contained in the R package \pkg{wpp2015BayesMig}.
}
\details{
\tabular{ll}{
Package: \tab wppExplorerBayesMig\cr
Version: \tab 0.2-1\cr
Date: \tab 2017-01-06\cr
Depends: \tab R (>= 3.0.0)\cr
License: \tab GPL (>= 2)
}

The main function of the packge is \code{\link{wpp.explore}} which opens an interactive interface in a web browser. A few helper functions are available for a fast access to the (possibly filtered) data, e.g. \code{\link{wpp.indicator}}.

%The interface can be also accessed online: \url{https://rstudio.stat.washington.edu/shiny/wppExplorer/inst/explore/}
}

\source{
	Population and migration projections were produced using the Azose et al. (2016) methodology. All historical estimates as well as projections of fertility and mortality are from the World Population Prospects 2015, the
United Nations, Department of Economic and Social Affairs, Population Division.
 }
 
 \references{
 	Azose, J.J., Sevcikova, H., Raftery, A.E. (2016): Probabilistic population projections with migration uncertainty.  Proceedings of the National Academy of Sciences, 113:6460-6465. \url{http://www.pnas.org/content/113/23/6460.full}
 	
 World Population Prospects: The 2015 Revision. (\url{http://esa.un.org/unpd/wpp}) Special Tabulations.
 
 A. E. Raftery,  N. Li, H. Sevcikova , P. Gerland, G. K. Heilig (2012). Bayesian probabilistic population projections for all countries. Proceedings of the National Academy of Sciences 109:13915-13921.
 
 P. Gerland, A. E. Raftery, H. Sevcikova, N. Li, D. Gu, T. Spoorenberg, L. Alkema, B. K. Fosdick, J. L. Chunn, N. Lalic, G. Bay, T. Buettner, G. K. Heilig,  J. Wilmoth (2014). World Population Stabilization Unlikely This Century. Science 346:234-237.
}



 \author{
Hana Sevcikova <hanas@uw.edu>, used code from a Joe Cheng's shiny example

Maintainer: Hana Sevcikova <hanas@uw.edu>
}

\seealso{
\code{\link[wpp2015BayesMig:wpp2015BayesMig-package]{wpp2015BayesMig}},  \code{\link[shiny:shiny-package]{shiny}}, \code{\link{wpp.explore}}, \code{\link{wpp.indicator}}
}

\keyword{ package }