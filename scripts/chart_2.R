# packages

library("dplyr")
library("plotly")
library("ggplot2")
library("stringr")
library("shiny")

# writing line plot function

ratings_plot <- function(amazon_data, disney_data, netflix_data, mark_size) {
  # filtering for year and rating
  all_ratings <- amazon_data %>%
    select(Year.of.release, Age.of.viewers) %>%
    summarise(year = as.character(Year.of.release), rated = Age.of.viewers) %>%
    bind_rows(select(disney_data, year, rated)) %>%
    filter(year == substr(year, start = 1, stop = 4)) %>%
    summarise(release_year = as.numeric(year), rating = rated) %>%
    bind_rows(select(netflix_data, release_year, rating))
  # standardizing the rating
  mpa_film_ratings <- all_ratings %>%
    pull(rating) %>%
    str_replace_all(c(
      "TV-G" = "G", "TV-Y" = "G", "All" = "G", "TV-PG" = "PG",
      "TV-Y7" = "PG", "TV-Y7-FV" = "PG", "7+" = "PG",
      "TV-14" = "PG-13", "13+" = "PG-13", "16+" = "PG-13",
      "PG-PG-13" = "PG-13", "TV-MA" = "R", "18+" = "R",
      "NC-1PG" = "NC-17", "GPG-FV" = "PG", "GPG" = "PG"
    )) %>%
    as.data.frame() %>%
    bind_cols(select(all_ratings, release_year)) %>%
    rename(., rated = ., year = release_year)
  # organizing ratings by year for plot
  ratings_by_year <- mpa_film_ratings %>%
    group_by(year) %>%
    summarise(
      num_rated = coalesce(table(rated == "G")["TRUE"], 0),
      mpa_rating = "G"
    ) %>%
    bind_rows(group_by(mpa_film_ratings, year) %>%
      summarise(
        num_rated = coalesce(table(rated == "PG")["TRUE"], 0)
        + coalesce(table(rated == "PG+")["TRUE"], 0),
        mpa_rating = "PG"
      )) %>%
    bind_rows(group_by(mpa_film_ratings, year) %>%
      summarise(
        num_rated = coalesce(
          table(rated == "PG-13")["TRUE"],
          0
        )
        + coalesce(table(rated == "PG-13+")["TRUE"], 0),
        mpa_rating = "PG-13"
      )) %>%
    bind_rows(group_by(mpa_film_ratings, year) %>%
      summarise(
        num_rated = coalesce(table(rated == "R")["TRUE"], 0)
        + coalesce(table(rated == "R+")["TRUE"], 0),
        mpa_rating = "R"
      )) %>%
    bind_rows(group_by(mpa_film_ratings, year) %>%
      summarise(
        num_rated = coalesce(
          table(rated == "NC-17")["TRUE"],
          0
        ),
        mpa_rating = "NC-17"
      )) %>%
    filter(!is.na(year))
  # line plot of ratings by year
  plot_ly(data = ratings_by_year,
          x = ~year,
          y = ~num_rated,
          name = ~mpa_rating,
          type = "scatter",
          mode = "lines+markers",
          color = ~mpa_rating,
          text = ~paste("Release Year:",
                        year,
                        "<br># of Movies/Shows:",
                        num_rated
                        ),
          colors = c("#5ab4ac", "coral", "maroon", "firebrick1", "olivedrab4"),
          marker = list(size = mark_size)
          ) %>%
    layout(
      title = paste(
        "Content on Streaming Services",
        "By Age Demographic and Release Year"
      ),
      xaxis = list(title = "Release Year"),
      yaxis = list(title = "# Of Movies/Shows (Content)")
    )
}
