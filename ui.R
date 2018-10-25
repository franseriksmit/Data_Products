#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Data"),
    
    # Sidebar with a slider input for number of bins 
    fluidRow(column(4,
                    selectInput('chop', choices = c("Fileid", "PID", "TK_MW","Bestandsnaam"), label = 'Select a divisor:',selected=NULL)), 
             column(4,uiOutput("deel1")),
             column(4,uiOutput("deel2")),
             fluidRow(column(4, selectInput('result',, multiple = TRUE, selectize = FALSE, selected=NULL,choices=unique(all$Result_Group),label="Select result")))
             
    ),
    
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: hidden; }"),
   
    plotlyOutput("z")
    
)
)