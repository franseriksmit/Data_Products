#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


shinyServer(function(input, output) {
    
    output$deel1 <- renderUI({
        
        if(input$chop=='PID' || input$chop=='Bestandsnaam'){
            keuze<-sort(unique(all$Fileid) )
        }else{
            ifelse(input$chop=='TK_MW',keuze<-sort(unique(as.numeric(all$TK_MW))),keuze<-sort(unique(all$Fileid)))}
            selectInput("chop2", 'Kies deel2', choices=keuze, multiple = TRUE, selectize = FALSE, selected=NULL)
       })
    
    output$deel2<-renderUI({
        if(!is.null(input$chop2)){
            if(input$chop=='PID' || input$chop=='Bestandsnaam'){
                keuze<-reactive({keuzes=input$chop2
                keuze2<-all[which(all$Fileid==keuzes),]
                if(input$chop=='Bestandsnaam'){
                    keuze2<-sort(unique(keuze2$Bestandsnaam))
                }else{
                    keuze2<-sort(unique(keuze2$PID))}
                })
                selectInput("chop3", "kies deel 3",choices=keuze(), selected=NULL, multiple = TRUE, selectize = FALSE,width="100%")
                
            }
        }
    })
    keuze3<-reactive({keuze4=input$chop3
    if(input$chop!='PID' && input$chop!='Bestandsnaam'){keuze3=""}})
    hakken<-reactive({
        if(input$chop=='PID' || input$chop=='Bestandsnaam'){
            plotten<-all %>% select(TK_CD,input$chop,Result_Group,waarde) %>% filter(Result_Group==input$result) %>% filter(.[[2]]==input$chop3)
        }else{
            plotten<-all %>% select(TK_CD,input$chop,Result_Group,waarde) %>% filter(Result_Group==input$result) %>% filter(.[[2]]==input$chop2)
        }
        if(is.na(input$result[2])){
        plotten<-plotten %>% select(TK_CD,input$chop,waarde)}else{
            plotten<-plotten %>% select(TK_CD,Result_Group, waarde)
        }
        plotten<-aggregate(plotten[,3]~plotten[,2]+plotten[,1], data=plotten, FUN="sum")
        colnames(plotten)<-c(input$chop,"TK_CD","waarde")
        plotten<-as.data.frame(plotten)
    })
    output$z<-renderPlotly({plot_ly(hakken(),x=~TK_CD,y=~waarde, type='scatter',mode='lines+markers', color=~get(input$chop))})
    
}
)