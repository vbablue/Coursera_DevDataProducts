library(shiny)


shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Oscars Winners from 1978 to 2014"),
    
    sidebarPanel(    
      p('This app shows the oscar winner along with other details for a given year. Data is available from 1978 to 2014. Data for this is pulled from boxofficemojo.com on the fly.'),
      p('Enter the Year you want to know the oscar movie details of in the text box "Year" and click Submit.'),
      p('Once the Submit button is clicked, you should see the result below with the year, movie details along with the box office collection.'),
      numericInput('year', 'Year', 2014, min = 1978, max = 2014, step = 1),
      submitButton('Submit')
    ),
    mainPanel(      
      p('This app consists of UI.R and server.R. The main function is oscars which is in the server.R. Code for this is on github.'),
      p('Function oscar takes year as the input and outputs the results of the oscar winning movie for that year'),
      h3('Oscar Winner details for the year '), 
      
      h4('Year entered'),
      verbatimTextOutput("year"),
      
      h4('Oscar Winner Details '),
      verbatimTextOutput("result")
    )
  )
)