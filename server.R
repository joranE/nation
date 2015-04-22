library(shiny)
library(shinydashboard)
source("helpers.R")
source("load_data.R")
source("load_nations.R")

shinyServer(function(input, output, session) {

  output$plotWJC <- renderPlot({
    wjc_plot(nations = input$nationInput)
  },height = 650)
  
  output$plotU23 <- renderPlot({
    u23_plot(nations = input$nationInput)
  },height = 650)
  
  output$plotMajDstMen <- renderPlot({
    nation_perf(nations = input$nationInput,sex = "Men",race_type = "Distance")
  })
  output$plotMajDstWom <- renderPlot({
    nation_perf(nations = input$nationInput,sex = "Women",race_type = "Distance")
  })
  output$plotMajSprMen <- renderPlot({
    nation_perf(nations = input$nationInput,sex = "Men",race_type = "Sprint")
  })
  output$plotMajSprWom <- renderPlot({
    nation_perf(nations = input$nationInput,sex = "Women",race_type = "Sprint")
  })

  output$plotDepDstMen <- renderPlot({
    nation_depth(nations = input$nationInput,sex = "Men",race_type = "Distance")
  })
  output$plotDepDstWom <- renderPlot({
    nation_depth(nations = input$nationInput,sex = "Women",race_type = "Distance")
  })
  output$plotDepSprMen <- renderPlot({
    nation_depth(nations = input$nationInput,sex = "Men",race_type = "Sprint")
  })
  output$plotDepSprWom <- renderPlot({
    nation_depth(nations = input$nationInput,sex = "Women",race_type = "Sprint")
  })
})
