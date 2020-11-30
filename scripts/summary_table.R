library("dplyr")
library("tidyr")
library("styler")
library("lintr")
library("formattable")
library("tidyverse")

# read the data file

amazon_df <- read.csv("data/amazon_prime_tv_shows.csv", stringsAsFactors = FALSE)
disney_df <- read.csv("data/disney_plus_shows.csv", stringsAsFactors = FALSE)
netflix_df <- read.csv("data/netflix_movies_and_tv.csv", stringsAsFactors = FALSE)

amazon_df <- amazon_df %>% 
  rename(
    imdb_rating = IMDb.rating,
    genre = Genre,
    language = Language,
    year = Year.of.release
  )

# The group calculation was done because each of the data sets
# we are using have different shows and movies from different companies.
# The data can be applied to show the total number of movies/shows in the set,
# the highest and lowest ratings, the most common language used, most common rating
# and the most common genre between all the shows/movies.

summary_table <- function(dataset) {
  get_summary <- dataset %>%
  group_by(year) %>%
  drop_na() %>%
  na.omit() %>%
  filter(!(plot == "N/A" | imdb_rating == "N/A" | imdb_votes == "N/A" | awards == "N/A"
           | country == "N/A" | language == "N/A" | actors == "N/A" | writer == "N/A"
           | director == "N/A" | genre == "N/A" | runtime == "N/A" | released_at == "N/A"
           | rated == "N/A" | metascore == "N/A" | imdb_id == "")
  ) %>%
  summarise(
    total_movies = n(),
    highest_rating = max(imdb_rating, na.rm = TRUE),
    lowest_rating = min(imdb_rating, na.rm = TRUE),
    most_common_language = max(language, na.rm = TRUE),
    most_common_rating = max(rated, na.rm = TRUE),
    most_common_genre = max(genre, na.rm = TRUE),
  ) %>%
  arrange(year)
  return(get_summary)
}

summary_table_format <- formattable(summary_table,
  align = c("l", "c", "c"),
  list(`Indicator Name` = formatter(
    "span",
    style = ~ style(
      color = "grey",
      font.weight = "bold"
    )
  ))
)

# I included the table to make summarize the big data frames and make the information
# easier to visualize when looking at the summarized table.
# The table shows the total number of movies in that year, the highest and lowest ratings
# in that year, the most common genre, and the most  common language used in all of the movies.