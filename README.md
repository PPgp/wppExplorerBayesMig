# wppExplorerBayesMig  

[![Travis-CI Build Status](https://travis-ci.org/PPgp/wppExplorerBayesMig.svg?branch=master)](https://travis-ci.org/PPgp/wppExplorerBayesMig)

Shiny-based R package to view data from the PPgp/wpp2015BayesMig package, which is a modified version of the World Population Prospects (WPP) published by the United Nations Population Division (package wpp2015). In this version of the data, uncertainty about migration was taken into account.

#####Reference:

Azose, J.J., &#352;ev&#269;&#237;kov&#225;, H., Raftery, A.E. (2016): <a href="http://www.pnas.org/content/113/23/6460.full">Probabilistic population projections with migration uncertainty</a>.  <i>Proceedings of the National Academy of Sciences</i> 113:6460–6465.

To start a session, from R do 
```R
library(wppExplorerBayesMig)
wpp.explore()
```
This will open the interface in your default web browser. To end the session, press the Esc key.

The package also offers various functions to retrieve the WPP indicators in R as data frames. See the help file for `?wpp.indicator`.


