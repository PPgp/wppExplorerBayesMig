\name{wpp.indicator}
\alias{wpp.indicator}
\title{
Accessing Data
}
\description{
An interface for accessing the underlying data, where datasets with observed and predicted data are merged. The resulting data frame is in a "melted" format.
}
\usage{
wpp.indicator(what, \dots)
}

\arguments{
  \item{what}{Name of indicator. Possible values are:
  	\describe{
  		\item{fert}{Total fertililty rate. Merges datasets \code{\link[wpp2015:tfr]{tfr}} and \code{\link[wpp2015:tfr]{tfrprojMed}}.} 
  		\item{leF}{Female life expectancy. Merges datasets \code{\link[wpp2015:e0F]{e0F}} and \code{\link[wpp2015:e0F]{e0Fproj}}.}
  		\item{leM}{Male life expectancy. Merges datasets \code{\link[wpp2015:e0M]{e0M}} and \code{\link[wpp2015:e0M]{e0Mproj}}.}
  		\item{tpop}{Total population. Uses datasets with age- and sex-specific population counts and agregates over sexes and ages.}
  		\item{tpopF}{Total female population. Uses datasets \code{\link[wpp2015BayesMig:popF]{popF}} and \code{\link[wpp2015BayesMig:popF]{popFprojMed}} and aggregates over ages.}
  		\item{tpopM}{Total male population. Uses datasets \code{\link[wpp2015BayesMig:popM]{popM}} and \code{\link[wpp2015BayesMig:popM]{popMprojMed}} and aggregates over ages.}
  		\item{mig}{Total net migration. The datasets \code{\link[wpp2015BayesMig:migration]{migration}} and \code{\link[wpp2015BayesMig:migproj]{migproj}} are merged.}
  		\item{migrate}{Annual migration rate per thousand population. For historical estimates, the rate is computed from net migration and population. The denominator is approximated with the average population (\eqn{(P_{t}+P_{t-1})/2}). Projections are taken from the \code{\link[wpp2015BayesMig:mrateproj]{mrateproj}} dataset.} 
  		\item{popagesex}{Population by sex and age. Uses merged datasets of \code{\link[wpp2015BayesMig:popM]{popM}} with  \code{\link[wpp2015BayesMig:popMprojMed]{popMprojMed}} and \code{\link[wpp2015BayesMig:popF]{popF}} with  \code{\link[wpp2015BayesMig:popFprojMed]{popFprojMed}}. It requires two arguments in \dots, namely \code{sexm=c("F", "M")} and \cr\code{agem=c("0-4", "5-9", ..., "95-99", "100+")}. The function aggregates population counts over the given sex and age groups.}
  		\item{mortagesex}{Mortality by sex and age. Uses datasets \code{\link[wpp2015:mxF]{mxF}} and \code{\link[wpp2015:mxM]{mxM}}. It requires two atguments in \dots, namely \code{sex} which is either "F" or "M", and \code{age} which is one of ("0", "1", "5", "10", "15", "20", ... "95", "100+").}
  		\item{fertage}{Age-specific fertility rate. Uses datasets \code{\link[wpp2015:tfr]{tfr}} and \code{\link[wpp2015:tfr]{tfrprojMed}} which are merged together and dataset \code{\link[wpp2015:percentASFR]{percentASFR}} to derive age-specific rates. It requires one argument in \dots, namely \code{age} which is one of ("15-19", "20-24", ..., "45-49").}
  		\item{pfertage}{Percent age-specific fertility. Corresponds to the dataset  \code{\link[wpp2015:percentASFR]{percentASFR}}. Argument \code{agem} as defined above giving one or more age categories is required.}
  		\item{sexratio}{Sex ratio at birth. Corresponds to the dataset \code{\link[wpp2015:sexRatio]{sexRatio}}.}
  		\item{medage}{Median age.}
  		\item{meanagechbear}{Mean age at childbearing.}
  		\item{meanageinchbearage}{Mean age of women in childbearing ages.}
  		\item{tdratio}{Total dependency ratio. Ratio of population of age 0 to 14 and 65+ to population of age 15-64.}
  		\item{chdratio}{Child dependency ratio. Ratio of population of age 0 to 14 to population of age 15-64.}
  		\item{oadratio}{Old-age dependency ratio. Ratio of population of age 65+ to population of age 15-64.}
  		\item{psratio}{Potential support ratio. Inverse of old-age dependency ratio.}
  		\item{popgrowth}{Average annual population growth (\eqn{log(P_t / P_{t-1})/5}).}
  		\item{fert.ci, leF.ci, leM.ci, tpop.ci, tpopF.ci, tpopM.ci, popagesex.ci, mig.ci, migrate.ci}{Lower or upper bound of the corresponding indicator. Requires argument \code{which.pi} which is one of \dQuote{80}, \dQuote{95}, \dQuote{half.child}, and an argument \code{bound} which is
  			either \dQuote{low} or \dQuote{high}. Arguments \code{sexm} and \code{agem} (as defined above, but of length one) are required for popagesex.ci.}
  	}
}
  \item{\dots}{Arguments passed to the underlying functions as described above.
}
}

%\details{
%%  ~~ If necessary, more details than the description above ~~
%}
\value{Data frame with columns \code{charcode} (alpha-2 ISO 3166 country code), \code{Year}, and \code{value}.}

%\references{
%% ~put references to the literature/web site here ~
%}
\author{
Hana Sevcikova
}
%\note{
%%  ~~further notes~~
%}

\seealso{
\code{\link{wpp.by.country}}, \code{\link{wpp.by.year}}
}
\examples{
	migrate <- wpp.indicator("migrate")
	\dontrun{
	# Histogram of migration rate
	print(qplot(value, data=migrate) + facet_wrap(~ Year))}
	\dontrun{
	mxM01 <- wpp.indicator("mortagesex", sex="M", age="0")
	# Plot map
	plot(gvisGeoMap(wpp.by.year(mxM01, 2050), locationvar='charcode', numvar='value'))}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ manip }
