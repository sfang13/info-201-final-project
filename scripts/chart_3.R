# packages

library("dplyr")
library("ggplot2")
library("stringr")
library("wesanderson")

# reading in csv files

disney_plus <- read.csv("data/disney_plus_shows.csv", stringsAsFactors = FALSE)
netflix <- read.csv("data/netflix_movies_and_tv_imdb_ratings.csv", stringsAsFactors = FALSE)

# writing scatter plot function

imdb_ratings_plot <- function(disney_plus, netflix) {
  rating_by_runtime <- disney_plus %>% # organizing rating by run time for plot
    filter(type == "movie", imdb_rating != "", imdb_rating != "N/A",
           runtime != "N/A") %>%
    select(runtime, imdb_rating) %>%
    mutate(imdb_rating = as.double(imdb_rating), source = "Disney Plus") %>%
    bind_rows(summarise(filter(netflix, type == "Movie"),
                        runtime = duration,
                        imdb_rating = rating,
                        source = "Netflix")) %>%
    filter(!is.na(runtime), !is.na(imdb_rating)) %>%
    mutate(runtime = as.numeric(str_remove_all(runtime, " min"))) %>%
    filter(source == "Netflix") %>%
    bind_rows(filter(rating_by_runtime, source == "Disney Plus"))
  ggplot(data = rating_by_runtime) + # organizing ratings by year for plot
    geom_point(aes(x = imdb_rating, 
                   y = runtime,
                   group = source,
                   color = source,
                   shape = source)) +
    labs(title = "Movies On Netflix and Disney+ By Rating and Duration",
         x = "IMDB Movie Rating",
         y = "Movie Runtime",
         color = "Streaming Platforms",
         shape = "Streaming Platforms") +
    scale_color_manual(values = c("goldenrod1", "skyblue3")) +
    theme(axis.text.x.bottom = element_text(size = 10))
}
