library("dplyr")
library("tidyr")
library("styler")
library("lintr")

# read the data file

amazon_df <- read.csv("data/amazon_prime_tv_shows.csv", stringsAsFactors = FALSE)
disney_df <- read.csv("data/disney_plus_shows.csv", stringsAsFactors = FALSE)
netflix_df <- read.csv("data/netflix_movies_and_tv.csv", stringsAsFactors = FALSE)

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

# I included the table to make summarize the big data frames and make the information
# easier to visualize when looking at the summarized table.
# The table shows the total number of movies in that year, the highest and lowest ratings
# in that year, the most common genre, and the most  common language used in all of the movies.