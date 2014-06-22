library(shiny)
library(ggplot2)
library(vcdExtra)
data(Baseball)

shinyServer(function(input, output) {
  
  dataset <- reactive({
    Baseball[sample(nrow(Baseball), input$sampleSize),]
  })
  
  output$plotTab <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$xSelector, y=input$ySelector)) + geom_point()
    
    if (input$colorSelector != 'None')
      p <- p + aes_string(color=input$colorSelector)
    
    facets <- paste(input$fRowSelector, '~', input$fColSelector)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    if (input$jitterCheckbox)
      p <- p + geom_jitter()
    if (input$smoothCheckbox)
      p <- p + geom_smooth()
    
    print(p)
    
  }, height=600)
  
  # Generate a summary of the data
  output$summaryTab <- renderPrint({
    summary(dataset())
  })
  
  # Generate an HTML table view of the data
  output$tableTab <- renderTable({
    data.frame(x=dataset())
  })
  
})