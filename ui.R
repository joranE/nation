library(shiny)
library(shinydashboard)
source("load_nations.R")

header <- dashboardHeader(title = "Statistical Skier")

sidebar <- dashboardSidebar(
  selectizeInput(inputId = "nationInput",
                 label = "Nation",
                 choices = c("Choose up to two..." = "",NATIONS),
                 selected = NULL,
                 multiple = TRUE,
                 options = list(maxItems = 2)),
  hr(),
  sidebarMenu(
    menuItem(text = "World Junior - U23",tabName = "wjcU23",icon = icon("bar-chart")),
    menuItem(text = "Major Results",tabName = "majInt",icon = icon("bar-chart")),
    menuItem(text = "Depth",tabName = "depth",icon = icon("bar-chart"))
  ),
  helpText("Joran Elias - statisticalskier.com"),
  hr(),
  helpText("Choose up to 2 nations to display.")
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "wjcU23",
      fluidRow(
        column(width = 6,
               box(plotOutput("plotWJC"),
                   width = NULL,
                   height = 725,
                   title = "WJC History",
                   solidHeader = TRUE,
                   status = "success")
        ),
        column(width = 6,
               box(plotOutput("plotU23"),
                   width = NULL,
                   height = 725,
                   title = "U23 History",
                   solidHeader = TRUE,
                   status = "success")
        )
      )
    ),
    
    tabItem(
      tabName = "majInt",
      fluidRow(
        column(width = 6,
               box(plotOutput("plotMajDstMen"),
                   width = NULL,
                   title = "Men's Distance",
                   solidHeader = TRUE,
                   collapsible = TRUE,
                   status = "primary"
               ),
               box(plotOutput("plotMajDstWom"),
                   width = NULL,
                   title = "Women's Distance",
                   solidHeader = TRUE,
                   collapsible = TRUE,
                   status = "primary"
               )
        ),
        
        column(width = 6,
               box(plotOutput("plotMajSprMen"),
                   width = NULL,
                   title = "Men's Sprint",
                   solidHeader = TRUE,
                   collapsible = TRUE,
                   status = "primary"
               ),
               box(plotOutput("plotMajSprWom"),
                   width = NULL,
                   title = "Women's Sprint",
                   solidHeader = TRUE,
                   collapsible = TRUE,
                   status = "primary"
               )
        )
      )
    ),
    
    tabItem(
      tabName = "depth",
      fluidRow(
        column(width = 6,
               box(plotOutput("plotDepDstMen"),
                   width = NULL,
                   title = "Men's Distance Depth",
                   solidHeader = TRUE,
                   collapsible = TRUE,
                   status = "primary"
               ),
               box(plotOutput("plotDepDstWom"),
                   width = NULL,
                   title = "Women's Depth",
                   solidHeader = TRUE,
                   collapsible = TRUE,
                   status = "primary"
               )
        ),
        
        column(width = 6,
               box(plotOutput("plotDepSprMen"),
                   width = NULL,
                   title = "Men's Sprint Depth",
                   solidHeader = TRUE,
                   collapsible = TRUE,
                   status = "primary"
               ),
               box(plotOutput("plotDepSprWom"),
                   width = NULL,
                   title = "Women's Sprint Depth",
                   solidHeader = TRUE,
                   collapsible = TRUE,
                   status = "primary"
               )
        )
      )
    )
  )  
)

dashboardPage(header,sidebar,body)
