library(shiny)
library(ggplot2)
library(vcdExtra)
data(Baseball)

dataset <- Baseball

shinyUI(pageWithSidebar(
  
  headerPanel("Baseball Data Explorer"),
  
  sidebarPanel(
    
    sliderInput('sampleSize', 'Data sample size', min=1, max=nrow(dataset),
    #            value=min(1000, nrow(dataset)), step=500, round=0),
                value=min(100, nrow(dataset)), step=25, round=0),
    
    selectInput('xSelector', 'X axe variable', names(dataset)[c(3:15,20:23)]),
    selectInput('ySelector', 'Y axe variable', names(dataset)[c(3:15,20:23)], names(dataset)[[2]]),
    selectInput('colorSelector', 'Color (Scale/Category)', c('None', names(dataset)[c(16,17,18,19,24,25)])),
    
    checkboxInput('jitterCheckbox', 'Jitter'),
    checkboxInput('smoothCheckbox', 'Smooth'),
    
    selectInput('fRowSelector', 'Facet row variable', c(None='.', names(dataset)[c(16,17,18,19,24,25)])),
    selectInput('fColSelector', 'Facet column variable', c(None='.', names(dataset)[c(16,17,18,19,24,25)]))
  ),
  
  mainPanel(
    #plotOutput('plot')
    tabsetPanel(
      tabPanel("Documentation",
               #includeMarkdown("doc/shinyDescription.md")
               includeHTML("doc/shinyDescription.html")
               ),
      tabPanel("Dynamic Plot",
               plotOutput(
                 "plotTab", 
                 height = "800px")),
                 #width = "800px")), 
      tabPanel("Data Summary", verbatimTextOutput("summaryTab")), 
      tabPanel("Data Table", tableOutput("tableTab"))
    )
  )
))