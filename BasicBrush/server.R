library(ggplot2)
source("/Users/briancarter1/Desktop/GitProject/PCA_Gauges/PCAGauge.R")


shinyServer(function(input, output) {
	
	#curdata<-reactive({})
	dat<-mtcars
	
	
	output$plot1 <- renderPlot({
		if (input$plot_type == "base") {
			plot(mtcars$wt, mtcars$mpg)
		} else if (input$plot_type == "ggplot2") {
			ggplot(mtcars, aes(wt, mpg)) + geom_point()
		}
	})
	
	output$plot2<-renderPlot({
		
		a<-quantile(range(mtcars$wt),probs=seq(0,1,1/input$splits))
		p<-gg.gauge2(a)
		#x    <- faithful[, 2]  # Old Faithful Geyser data
		#bins <- seq(min(x), max(x), length.out = input$bins + 1)
		
		if(length(brushedPoints(mtcars,input$plot_brush)$wt)>0){
			pos1=round(mean(brushedPoints(mtcars,input$plot_brush)$wt),2)
		}
		else{
			pos1=round(mean(mtcars$wt),2)
		}
		
		
		#pos1=mean(brushedPoints(mtcars, input$plot_brush)$wt)
		pos=rescale2(pos1,range(mtcars$wt))
		
		p<-p+geom_polygon(data=get.poly(pos-1,pos+1,0.2),aes(x,y),alpha=0.5)+
			annotate("text",x=0,y=0,label=pos1,vjust=0,size=8,fontface="bold")
		
		output$brush_info <- renderPrint({
			brushedPoints(mtcars, input$plot_brush)$wt
		})
		
		
		return(p)
		
		
		
	
	})
	
	output$click_info <- renderPrint({
		cat("input$plot_click:\n")
		str(input$plot_click)
	})
	
	output$hover_info <- renderPrint({
		cat("input$plot_hover:\n")
		str(input$plot_hover)
	})
	
	output$dblclick_info <- renderPrint({
		cat("input$plot_dblclick:\n")
		str(input$plot_dblclick)
	})
	
	output$brush_info <- renderPrint({
		cat("input$plot_brush:\n")
		str(input$plot_brush)
	})
	
	#output$brush_info <- renderPrint({
		#brushedPoints(mtcars2, input$plot1_brush)
	#})
	
	
	
	
})