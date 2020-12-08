library("shiny")
library("plotly")
library("shinythemes")

# Chris' overview page --------
overview_page <- tabPanel(
  "Data Visualization on Movies and TV Shows",
  sidebarLayout(
    overview_sidepanel,
    overview_mainpanel
  )
)

overview_sidepanel <- sidebarPanel(
  h2("test"),
  p("test test")
)

overview_mainpanel <- mainPanel(
  h1("Overview"),
  h2("Purpose:"),
  p("This project's purpose is to analyze TV shows and movies from",
    strong("Netflix"), ", ", strong("Amazon Prime"), ", and ", strong("Disney Plus"), 
    "to give ourselves further insight and reveal trends that
    have developed over the years. "),
  h4("These are the sources we have used in this project:"),
  a("     1. Netflix data", href="https://www.kaggle.com/shivamb/netflix-shows"),
  a("     2. Disney Plus data", href="https://www.kaggle.com/unanimad/disney-plus-shows"),
  a("     3. Amazon Prime data", href="https://www.kaggle.com/nilimajauhari/amazon-prime-tv-shows"),
  p("From this data observation, we will be able to answer
    the following questions:"),
  h5("What are the user demographics of various streaming platforms?
     How have they changed over time?"),
  h5("What genres are most popular on each streaming platform?
     How have the popular genres changed over time?"),
  h5("How have the duration, ratings, viewers, and genres of tv shows and movies
     on various streaming platforms changed over the years? In 2020?"),
  p("We will be using our skills that we've learned throughout this quarter to
    analyze the datasets and obtain valuable information from them."),
)


#hannah's chart page --------

#creates side panel with widgets for chart 1 page
chart1_side_panel <- sidebarPanel(
  
)

#creates main panel with actual bar graph for chart 1 page
chart1_main_panel <- mainPanel(
  h1("What genres are most popular on each streaming platform? Do these align
     with other streaming platforms?"),
  plotlyOutput("chart1")
)

#creates the actual chart 1 page
chart_page_one <- tabPanel(
  "Popularity of Genres for TV Shows",
  sidebarLayout(
    chart1_side_panel,
    chart1_main_panel
  )
)

# ---------------------------




#ui for creating shinyApp
ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
  "Streaming Services",
  overview_page,
  chart_page_one
  )
)
