# packages

library("dplyr")
library("ggplot2")
library("stringr")

# writing scatter plot function

imdb_ratings_plot <- function(disney_data, netflix_2_data) {
  rating_by_runtime <- disney_data %>% # organizing rating by run time for plot
    filter(
      type == "movie", imdb_rating != "", imdb_rating != "N/A",
      runtime != "N/A"
    ) %>%
    select(runtime, imdb_rating) %>%
    mutate(imdb_rating = as.double(imdb_rating), source = "Disney Plus") %>%
    bind_rows(summarise(filter(netflix_2_data, type == "Movie"),
      runtime = duration,
      imdb_rating = rating,
      source = "Netflix"
    )) %>%
    filter(!is.na(runtime), !is.na(imdb_rating)) %>%
    mutate(runtime = as.numeric(str_remove_all(runtime, " min")))
  # organizing "Disney Plus" and "Netflix" for plot
  rating_by_runtime_ordered <- rating_by_runtime %>%
    filter(source == "Netflix") %>%
    bind_rows(filter(rating_by_runtime, source == "Disney Plus"))
  # line plot of ratings by run time
  ggplot(data = rating_by_runtime_ordered) +
    geom_point(aes(
      x = imdb_rating,
      y = runtime,
      group = source,
      color = source,
      shape = source
    )) +
    labs(
      title = "Movies On Netflix and Disney+ By Rating and Duration",
      x = "IMDB Movie Rating",
      y = "Movie Runtime",
      color = "Streaming Platforms",
      shape = "Streaming Platforms"
    ) +
    scale_color_manual(values = c("goldenrod1", "skyblue3")) +
    theme(axis.text.x.bottom = element_text(size = 10))
}
