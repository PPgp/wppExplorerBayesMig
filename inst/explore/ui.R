library(shinythemes)

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

 
shinyUI(
fluidPage(theme = shinytheme("yeti"),
  titlePanel(paste("WPP", wppExplorerBayesMig:::get.wpp.year(), "Explorer with Migration Uncertainty")),
 sidebarLayout(
  sidebarPanel(
    shinyjs::useShinyjs(),
    geochartPrereqs,
    tags$head(
		tags$style(type='text/css', ".span4 { max-width: 270px; }")
	),
    uiOutput('yearUI'),
    hr(),
    selectInput('indicator', h5('Indicator:'), wppExplorerBayesMig:::wpp.data.env$indicators),
    conditionalPanel(condition=paste("input.indicator >", sum(attr(wppExplorerBayesMig:::wpp.data.env$indicators, "settings")$by.age == FALSE)),
    	tags$head(tags$style(type="text/css", "#selagesmult { height: 150px; width: 85px}"),
    			  tags$style(type="text/css", "#selages { width: 85px}"),
    			  tags$style(type="text/css", "#indsexmult { height: 55px; width: 95px}"),
    			  tags$style(type="text/css", "#indsex { width: 95px}")
    	),
    	fluidRow(
			column(4, offset=2, uiOutput('sexselection')),
    		column(3, offset=1, uiOutput('ageselection'))
    	)
    ),
    htmlOutput('indicatorDesc'),
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
      	 fluidRow(
		column(6, checkboxInput('normalizeMapAndCountryPlot', 'Fixed scale over time', TRUE))
		),
		fluidRow(
		column(6, offset=5, textOutput('mapyear'))
			),		
		hr(),
		geochart('map'),
		#htmlOutput('mapgvis'),
		hr(),
		conditionalPanel(condition='input.map_selection',
				plotOutput('countryPlot', height='300px'))
      ),
      tabPanel('Sortable Data', 
      	fluidRow(
		column(6, checkboxInput('includeAggr2', 'Include Aggregations', FALSE))
		),
	fluidRow(
		column(6, offset=5, textOutput('year2'))
		),
		hr(),
      	DT::dataTableOutput('stable')
      ),
      tabPanel('Trends & Pyramids',
  		tags$head(
			tags$style(type="text/css", "#seltcountries { height: 450px}"),
			tags$style(type="text/css", "#trendstable { overflow-x: scroll}")
			),
			fluidPage(
				fluidRow(
					fluidRow(HTML("<br>")),
					column(3, uiOutput('cselection')),
				  	column(9, 
				  		tabsetPanel(
				  				tabPanel('Trends', 
				  					plotOutput('probtrends', 
				  							click = "probtrends_values", hover = "probtrends_values", 
				  							dblclick = "probtrends_zoom_reset", 
				  							brush = brushOpts(id = "probtrends_zoom", resetOnNew = TRUE)),
				  					flowLayout(
										checkboxInput('trend.logscale', 'Log scale', FALSE),
										textOutput("probtrends_selected")
										)
				  					),
				  				tabPanel('Age Profile', 
				  					googleLineChart('age.profileM', options=list(height=200)),
				  					googleLineChart('age.profileF', options=list(height=200)),
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
				  				), type="pills"
				  			)
				  		)
 					),
 				fluidRow(
 					column(12, textOutput('trendstabletitle'),
 						   tableOutput('trendstable'))
 					)
 				)
 		),
 	tabPanel('Histogram',
 		flowLayout(
      		checkboxInput('fiXscaleHist', 'Fixed x-axis over time', FALSE)
      	),
      	hr(),
      	#plotOutput('hist')
      	htmlOutput('ghist')
    ),
	tabPanel('Probability Calc',
		tags$head(
			tags$style(HTML('#probcalculate{background-color:lightblue}')),
			tags$style(type="text/css", "#probcalc_result { overflow-x: scroll}")
			),
		fluidPage(
				fluidRow(HTML("<br>")),
				fluidRow(
					column(12, 
						HTML("<h5><font color='#d95f0e'><b>Probability that population in the selected country will be larger/smaller than the threshold:</b></font></h5>"))
				),
				fluidRow(
					column(12, HTML("<p></p>"))
				),
				fluidRow(
					column(3, uiOutput('cselection_single')),
					column(3, textInput("probcalc_threshold", "Threshold (in thousands):")),
					column(3, radioButtons("probcalc_direction", label="", choices=list(larger=1, smaller=0), selected=1, inline=TRUE))
				),
				fluidRow(
					column(3, actionButton('probcalculate', 'Calculate Probability'))
				),
				fluidRow(
					column(12, HTML("<p></p><p></p>"))
				),
				fluidRow(
					column(12, HTML("<h5><font color='#d95f0e'><b>Results:</b></font></h5>"),
						textOutput('probcalctabletitle'))
				),
				fluidRow(
					column(12, tableOutput("probcalc_result"))
				)
		)	
	),   
    tabPanel('Rosling Chart',
		htmlOutput('graphgvis'),
		HTML("<br>"),
		fluidRow(column(1,"")),
		fluidRow(
			column(3, offset=1, textOutput('AddIndicatorText')),
			column(1, actionButton("AddIndicator", "Add indicator"))
			)
      ),
      tabPanel("Help",
      	includeHTML("README.html")
      ) 
      ) #end tabsetPanel
  ) #end mainPanel
)))
