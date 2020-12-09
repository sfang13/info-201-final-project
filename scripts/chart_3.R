# packages

library("dplyr")
library("ggplot2")
library("stringr")

# writing scatter plot function

imdb_ratings_plot <- function(disney_data, netflix_2_data, data_val) {
  # organizing rating by runtime for plot
  rating_by_runtime <- disney_data %>%
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
  # scatter plot of ratings by runtime
  plot_ly(
    data = rating_by_runtime,
    x = ~imdb_rating,
    y = ~runtime,
    name = ~source,
    type = "scatter",
    mode = "markers",
    color = ~source,
    text = ~ paste(
      "Rating:", imdb_rating, "<br>Runtime:",
      runtime
    ),
    colors = c("tomato", "olivedrab4"),
    opacity = 0.5
  ) %>%
    layout(
      title = "Movies On Netflix and Disney+ By Rating and Duration",
      xaxis = list(title = "IMDB Movie Rating"),
      yaxis = list(title = "Movie Runtime (min)")
    )
}
