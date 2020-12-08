library(dplyr)
library(ggplot2)
library(stringr)
library(RColorBrewer)
library(plotly)
library(lintr)

chart_1 <- function(netflix_data, disney_data, amazon_data, color) {
  #organizing and universalizing netflix data
  netflix_genres <- netflix_data %>%
    filter(type == "TV Show") %>%
    mutate(genre = word(listed_in, 1))
  netflix_genres_list <- netflix_genres %>%
    pull(genre) %>%
    str_replace_all(c(
      "Docuseries," = "Documentary", "Docuseries" = "Documentary",
      "Kids'" = "Kids", "British" = "International"
      ))
  netflix_genres <- netflix_genres %>%
    mutate(genre = netflix_genres_list) %>%
    count(genre) %>%
    mutate(streaming_service = "Netflix")
  netflix_genres <- netflix_genres[-c(11), ]
  netflix_total <- netflix_genres %>%
    summarize(sum_shows = sum(n)) %>%
    pull(sum_shows)
  netflix_genres <- netflix_genres %>%
    mutate(percent = round((n / netflix_total) * 100, 2)) %>%
    top_n(5)


  #organizing and universalizing disney+ data
  disney_genres <- disney_data %>%
    filter(type == "series") %>%
    mutate(genre = word(genre, 1))
  disney_genres_list <- disney_genres %>%
    pull(genre) %>%
    str_replace_all(c(
      "Action," = "Action", "Adventure," = "Adventure",
      "Animation," = "Animation", "Comedy," = "Comedy", "Drama," = "Drama",
      "Documentary," = "Documentary", "Family," = "Family",
      "Musical," = "Musical", "Short," = "Short"
    ))
  disney_genres <- disney_genres %>%
    mutate(genre = disney_genres_list) %>%
    count(genre) %>%
    mutate(streaming_service = "Disney+")
  disney_genres <- disney_genres[-c(9), ]
  disney_total <- disney_genres %>%
    summarize(sum_shows = sum(n)) %>%
    pull(sum_shows)
  disney_genres <- disney_genres %>%
    mutate(percent = round((n / disney_total) * 100, 2)) %>%
    top_n(5)


  #organizing and universalizing amazon prime video data
  amazon_genres <- amazon_data %>%
    mutate(genre = word(Genre, 1))
  amazon_genres_list <- amazon_genres %>%
    pull(genre) %>%
    str_replace_all(c(
      "Action," = "Action", "Animation," = "Animation", "Arts," = "Arts",
      "Comedy," = "Comedy", "Drama," = "Drama", "Fantasy," = "Fantasy",
      "Kids," = "Kids", "Sci-fi," = "Sci-fi", "Sports," = "Sports"
      ))
  amazon_genres <- amazon_genres %>%
    mutate(genre = amazon_genres_list) %>%
    count(genre) %>%
    mutate(streaming_service = "Amazon Prime Video")
  amazon_genres <- amazon_genres[-c(1), ]
  amazon_total <- amazon_genres %>%
    summarize(sum_shows = sum(n)) %>%
    pull(sum_shows)
  amazon_genres <- amazon_genres %>%
    mutate(percent = round((n / amazon_total) * 100, 2)) %>%
    top_n(5)


  #combining the three dataframes
  joined <- full_join(netflix_genres, amazon_genres)
  joined <- full_join(joined, disney_genres)


  #making the bar chart
  chart1 <- ggplot(data = joined, aes()) +
    geom_col(mapping = aes(x = streaming_service, y = percent, fill = genre),
             position = "dodge") +
    labs(y = "Percent of Total Shows on Platform",
         x = "Streaming Platforms",
         title = "Genre Popularity for TV Shows on Three Streaming Platforms") +
    scale_fill_brewer(palette = color) +
    theme(plot.title = element_text(hjust = 0.5), legend.title.align = 0.5)

  #making the bar chart interactive
  ggplotly(chart1)

}
