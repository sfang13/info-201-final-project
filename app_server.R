library("dplyr")
library("ggplot2")
library("plotly")
library("shiny")

#read in datasets
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

#read in chart files
source("scripts/chart_1.R")
source("scripts/chart_2.R")
source("scripts/chart_3.R")

server <- function(input, output) {
  output$chart1 <- renderPlotly(
    return(chart_1(netflix_data, disney_data, amazon_data))
  )
}
