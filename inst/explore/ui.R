geochartPrereqs <- tagList(
  tags$head(
    tags$script(src="https://www.google.com/jsapi"),
    tags$script(src="geochart.js")
  )
)

geochart <- function(id, options=list()) {
  tags$div(id=id, class="shiny-geochart-output", `data-options`=RJSONIO::toJSON(options))
}

googleLineChart <- function(id, options=list()) {
  tags$div(id=id, class="google-linechart-output", `data-options`=RJSONIO::toJSON(options))
}

googleHistogram <- function(id, options=list()) {
  tags$div(id=id, class="google-histogram-output", `data-options`=RJSONIO::toJSON(options))
}

row <- function(...) {
	tags$div(class="row", ...)
}

col <- function(width, ...) {
	#tags$div(class=paste0("span", width), ...)
 tags$div(class=paste0("col-sm-", width), ...)
}

 
shinyUI(pageWithSidebar(
  headerPanel(paste("WPP", wppExplorerBayesMig:::get.wpp.year(), "Explorer with Migration Uncertainty")),
  sidebarPanel(
    shinyjs::useShinyjs(),
    geochartPrereqs,
    tags$head(
         		#tags$style(type="text/css", ".jslider { max-width: 50px; }"),
         		#tags$style(type='text/css', ".well { padding: 0px; margin-bottom: 5px; max-width: 100px; }"),
		tags$style(type='text/css', ".span4 { max-width: 270px; }")
	),
    uiOutput('yearUI'),
    hr(),
    selectInput('indicator', h5('Indicator:'), wppExplorerBayesMig:::wpp.data.env$indicators),
    conditionalPanel(condition=paste("input.indicator >", sum(attr(wppExplorerBayesMig:::wpp.data.env$indicators, "settings")$by.age == FALSE)),
    	tags$head(tags$style(type="text/css", "#selagesmult { height: 150px; width: 70px}"),
    			  tags$style(type="text/css", "#selages { height:25px; width: 70px}"),
    			  tags$style(type="text/css", "#indsexmult { height: 50px; width: 90px}"),
    			  tags$style(type="text/css", "#indsex { height: 25px; width: 90px}")),
    	row(
			col(2, ''),
			col(4, uiOutput('sexselection')),
			col(1, ''),
    		col(3, uiOutput('ageselection'))
    	)
    ),
    textOutput('indicatorDesc'),
    hr(),
    selectInput('uncertainty', h5('Uncertainty:'), structure(as.character(1:3), names=c('80%', '95%', '+-1/2child')), 
    			multiple=TRUE, selected=1),
    textOutput('uncertaintyNote'),
    hr(),
    HTML("<p><small><b>Data Source:</b> Based on estimates for 1950-2015 from <a href='http://esa.un.org/unpd/wpp' target='_blank'>World Population Prospects 2015</a>. Probabilistic projections including migration uncertainty based on <a href='http://www.pnas.org/content/113/23/6460.full' target='_blank'>Azose et al. (2016, PNAS)</a>. Note: These are not official <a href='https://rstudio.stat.washington.edu/shiny/wppExplorer/inst/explore/' target='_blank'> UN projections</a>.</small></p><p><small>&copy; Hana &#352;ev&#269;&#237;kov&#225;, <a href='https://www.csss.washington.edu' target='_blank'>CSSS</a>, University of Washington; <a href='http://bayespop.csss.washington.edu' target='_blank'>project website</a></small></p>"),
width=3
  ),
  mainPanel(
    shinyjs::useShinyjs(),
    tabsetPanel(
      tabPanel('Map',
      	 flowLayout(
			textOutput('mapyear'),
			checkboxInput('normalizeMapAndCountryPlot', 'Fixed scale over time', TRUE)
		),		
		hr(),
		geochart('map'),
		#htmlOutput('mapgvis'),
		hr(),
		conditionalPanel(condition='input.map_selection',
				plotOutput('countryPlot', height='300px'))
      ),
      #tabPanel('Data', 
		#textOutput('year1'),
		#checkboxInput('includeAggr1', 'Include Aggregations', FALSE),
      	#tableOutput('table')
      #),
      tabPanel('Sortable Data', 
      	flowLayout(
			textOutput('year2'),
			checkboxInput('includeAggr2', 'Include Aggregations', FALSE)
		),
		hr(),
      	DT::dataTableOutput('stable')
      ),
      tabPanel('Trends & Pyramids',
  		tags$head(
			tags$style(type="text/css", "#seltcountries { height: 450px; width: 150px}")
			),
			tags$div(
				class = "container",
				row(
					col(0.5, ''),
					col(2, uiOutput('cselection')),
				  	col(7, tabsetPanel(
				  				#tabPanel('Median',
				  				#	googleLineChart('trends', options=list(height=400, width=650)),
				  				#	checkboxInput('median.logscale', 'Log scale', FALSE)),
				  				tabPanel('Trends', 
				  					plotOutput('probtrends', height="400px", width="650px", 
				  							click = "probtrends_values", hover = "probtrends_values", 
				  							dblclick = "probtrends_zoom_reset", 
				  							brush = brushOpts(id = "probtrends_zoom", resetOnNew = TRUE)),
				  					flowLayout(
										checkboxInput('trend.logscale', 'Log scale', FALSE),
										textOutput("probtrends_selected")
										)
				  					),
				  				tabPanel('Age Profile', 
				  					googleLineChart('age.profileM', options=list(height=200, width=650)),
				  					googleLineChart('age.profileF', options=list(height=200, width=650)),
				  					checkboxInput('aprofile.logscale', 'Log scale', FALSE)),
				  				tabPanel('Pyramids', 
				  					plotOutput('pyramids', click = "pyramid_values", hover = "pyramid_values", 
				  						dblclick = "pyramid_zoom_reset",
				  						brush = brushOpts(id = "pyramid_zoom", resetOnNew = TRUE)
									),
				  					flowLayout(
				  						checkboxInput('proppyramids', 'Pyramid of proportions', FALSE),
				  						textOutput("pyramid_selected")
									)
				  				)
				  			)
				  		)
 					),
 				row(
 					col(0.5, ''),
 					col(9, textOutput('trendstabletitle'),
 						   tableOutput('trendstable'))
 					)
 				)
 		),
 	tabPanel('Histogram',
 		#textOutput('year3'),
 		#hr(),
 		flowLayout(
      	checkboxInput('fiXscaleHist', 'Fixed x-axis over time', FALSE)
      	),
      	hr(),
      	#plotOutput('hist')
      	htmlOutput('ghist')
    ),
	tabPanel('Probability Calc',
		tags$head(
			tags$style(HTML('#probcalculate{background-color:lightblue}'))
			),
		tags$div(
			class = "container",
			row(
				col(0.5, ''),
				col(10, HTML("<h5><font color='#d95f0e'><b>Probability that population in the selected country will be larger/smaller than the threshold:</b></font></h5>"))
			),
			row(
				col(0.5, ''),
				col(10, HTML("<p></p>"))
			),
			row(
				col(0.5, ''),
				col(3, uiOutput('cselection_single')),
				col(3, textInput("probcalc_threshold", "Threshold (in thousands):")),
				col(3, radioButtons("probcalc_direction", label="", choices=list(larger=1, smaller=0), selected = 1, inline = TRUE))				
				),
			row(
				col(0.5, ''),
				col(3, actionButton('probcalculate', 'Calculate Probability'))
				),
			row(
				col(0.5, ''),
				col(10, HTML("<p></p><p></p>"))
			),
			row(
				col(0.5, ''),
				col(9, HTML("<h5><font color='#d95f0e'><b>Results:</b></font></h5>"),
					textOutput('probcalctabletitle'))
			),
			row(
				col(0.5, ''),
				col(10, tableOutput("probcalc_result"))
			)
		)	
	),   
      tabPanel('Rosling Chart',
		htmlOutput('graphgvis'),
		row(col(1, "")),
		row(
			col(1,""),
			col(3, textOutput('AddIndicatorText')),
			col(1, actionButton("AddIndicator", "Add indicator"))
			)
      ),
      tabPanel("Help",
      	includeHTML("README.html")
      )
  ) #end tabsetPanel
  ) #end mainPanel
))