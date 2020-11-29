# packages

library("dplyr")
library("ggplot2")
library("stringr")

# reading in csv files

amazon_prime <- read.csv("data/amazon_prime_tv_shows.csv",
  stringsAsFactors = FALSE
)
disney_plus <- read.csv("data/disney_plus_shows.csv", stringsAsFactors = FALSE)
netflix <- read.csv("data/netflix_movies_and_tv.csv", stringsAsFactors = FALSE)

# writing line plot function

ratings_plot <- function(amazon_prime, disney_plus, netflix) {
  all_ratings <- amazon_prime %>% # filtering for year and rating
    select(Year.of.release, Age.of.viewers) %>%
    summarise(year = as.character(Year.of.release), rated = Age.of.viewers) %>%
    bind_rows(select(disney_plus, year, rated)) %>%
    filter(year == substr(year, start = 1, stop = 4)) %>%
    summarise(release_year = as.numeric(year), rating = rated) %>%
    bind_rows(select(netflix, release_year, rating))
  mpa_film_ratings <- all_ratings %>% # standardizing the rating
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
  ratings_by_year <- mpa_film_ratings %>% # organizing ratings by year for plot
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
  ggplot(data = ratings_by_year, aes(
    x = year, # line plot of ratings by year
    y = num_rated,
    group = mpa_rating,
  )) +
    geom_line(aes(color = mpa_rating)) +
    geom_point(aes(color = mpa_rating)) +
    labs(
      title = "# Of Movies Released Each Year For Each Age Demographic",
      x = "Year",
      y = "# Of Movies",
      color = "Rating"
    ) +
    scale_color_manual(
      values = c("#5ab4ac", "coral", "maroon", "firebrick1", "olivedrab4")
    ) +
    theme(axis.text.x.bottom = element_text(size = 10))
}
