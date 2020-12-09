library("dplyr")
library("ggplot2")
library("plotly")
library("shiny")

# read in datasets
amazon_data <- read.csv("data/amazon_prime_tv_shows.csv",
  stringsAsFactors = FALSE
)
disney_data <- read.csv("data/disney_plus_shows.csv",
  stringsAsFactors = FALSE
)
netflix_data <- read.csv("data/netflix_movies_and_tv.csv",
  stringsAsFactors = FALSE
)
netflix_2_data <- read.csv("data/netflix_movies_and_tv_imdb_ratings.csv",
  stringsAsFactors = FALSE
)

# read in chart files
source("scripts/chart_1.R")
source("scripts/chart_2.R")
source("scripts/chart_3.R")

server <- function(input, output) {
  output$chart1 <- renderPlotly(
    return(chart_1(
      netflix_data, disney_data, amazon_data, input$color,
      input$number
    ))
  )
  output$chart_2 <- renderPlotly(
    return(ratings_plot(
      amazon_data, disney_data, netflix_data,
      input$mark_size
    ))
  )
  output$chart_3 <- renderPlotly(
    return(ratings_plot(
      disney_data, netflix_2_data,
      input$mark_size
    ))
  )
}
