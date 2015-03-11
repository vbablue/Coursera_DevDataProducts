library(shiny)

oscars <- function(year){
  #Loading libraries
  library(XML)
  library(lubridate)
  library(dplyr)
  
  #Reading the url, getting the tabel and converting it to a data frame
  url <- "http://www.boxofficemojo.com/oscar/"
  table=readHTMLTable(url)
  movies <- table[4]
  movies <- as.data.frame(movies)
  
  #Changing the column names to something readable
  colnames(movies) <- c("Year", "Picture", "Studio", "Box_Office", "Nominations", "Wins", "Release_Date")
  
  #New Dataset with the month column 
  movies_new <- movies %>% mutate(Release_Date = mdy(paste(Release_Date,"/",Year, sep="")), Release_Month=month(Release_Date,label=TRUE ))
  return <- movies_new %>% filter(Year == year) %>% select(-Release_Date)
  return
}

shinyServer(
  function(input, output) {
    output$year <- renderPrint({input$year})
    output$result <- renderPrint({oscars(input$year)})
  }
)