

shinyUI(fluidPage(
	# Some custom CSS for a smaller font for preformatted text
#	tags$head(
#		tags$style(HTML("
#										pre, table.table {
#										font-size: smaller;
#										}
#										"))
#		),
	includeCSS("bootstrap.min.css"),
	fluidRow(
		column(width = 4, wellPanel(
			radioButtons("plot_type", "Plot type",
									 c("ggplot2", "ggplot2")
			),
			sliderInput("splits",
									"Number of splits:",
									min = 2,
									max = 100,
									value = 4),
			sliderInput("gauge",
									"Value of Gauge",
									min=min(mtcars$wt),
									max=max(mtcars$wt),
									value=round(mean(mtcars$wt),0))	
			
		
		)),
		column(width = 4,
					 # In a plotOutput, passing values for click, dblclick, hover, or brush
					 # will enable those interactions.
					 plotOutput("plot1", height = 350,
					 					 # Equivalent to: click = clickOpts(id = "plot_click")
					 					 click = "plot_click",
					 					 dblclick = dblclickOpts(
					 					 	id = "plot_dblclick"
					 					 ),
					 					 hover = hoverOpts(
					 					 	id = "plot_hover"
					 					 ),
					 					 brush = brushOpts(
					 					 	id = "plot_brush"
					 					 )
					 )
		)
	),
	fluidRow(
		column(width = 3,
					 verbatimTextOutput("click_info")
		),
		column(width = 3,
					 verbatimTextOutput("brush_info")
		),
		column(width=6,
					plotOutput("plot2")
		)
	)
		))