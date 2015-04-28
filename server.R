library(shiny)
library(shinydashboard)
#library(Cairo)
#options(shiny.usecairo = TRUE)
source("helpers.R")
source("load_data.R")
source("load_nations.R")

IMG_RES <- 100

shinyServer(function(input, output, session) {

  output$plotWJC <- renderPlot({
    wjc_plot(nations = input$nationInput)
  },res = IMG_RES,height = 650)
  
  output$plotU23 <- renderPlot({
    u23_plot(nations = input$nationInput)
  },res = IMG_RES,height = 650)
  
  output$plotMajDstMen <- renderPlot({
    nation_perf(nations = input$nationInput,sex = "Men",race_type = "Distance")
  },res = IMG_RES)
  output$plotMajDstWom <- renderPlot({
    nation_perf(nations = input$nationInput,sex = "Women",race_type = "Distance")
  },res = IMG_RES)
  output$plotMajSprMen <- renderPlot({
    nation_perf(nations = input$nationInput,sex = "Men",race_type = "Sprint")
  },res = IMG_RES)
  output$plotMajSprWom <- renderPlot({
    nation_perf(nations = input$nationInput,sex = "Women",race_type = "Sprint")
  },res = IMG_RES)

  output$plotDepDstMen <- renderPlot({
    nation_depth(nations = input$nationInput,sex = "Men",race_type = "Distance")
  },res = IMG_RES)
  output$plotDepDstWom <- renderPlot({
    nation_depth(nations = input$nationInput,sex = "Women",race_type = "Distance")
  },res = IMG_RES)
  output$plotDepSprMen <- renderPlot({
    nation_depth(nations = input$nationInput,sex = "Men",race_type = "Sprint")
  },res = IMG_RES)
  output$plotDepSprWom <- renderPlot({
    nation_depth(nations = input$nationInput,sex = "Women",race_type = "Sprint")
  },res = IMG_RES)
})
