# packages

library("dplyr")
library("ggplot2")
library("stringr")

# writing line plot function

ratings_plot <- function(amazon_data, disney_data, netflix_data) {
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
  ggplot(data = ratings_by_year, aes(
    x = year,
    y = num_rated,
    group = mpa_rating
  )) +
    geom_line(aes(color = mpa_rating)) +
    geom_point(aes(color = mpa_rating)) +
    labs(
      title = paste(
        "Content On Netflix, Amazon Prime, and Disney+",
        "By Age Demographic and Release Year"
      ),
      x = "Release Year",
      y = "# Of Movies/Shows (Content)",
      color = "Rating"
    ) +
    scale_color_manual(
      values = c("#5ab4ac", "coral", "maroon", "firebrick1", "olivedrab4")
    ) +
    theme(axis.text.x.bottom = element_text(size = 10))
}
