library("dplyr")
library("tidyr")
library("styler")
library("lintr")

get_summary_info <- function(dataset) {
  summary_table <- list()
  summary_table$number_of_movies <- nrow(dataset)
  summary_table$averge_imdb_rating/year <- dataset %>%
    group_by(year) %>%
    summarise(
      average_imdb_rating = mean(imdb_rating)
    )
    select(average_imdb_rating)
  summary_table$averge_imdb_rating/genre <- dataset %>%
    group_by(genre) %>%
    summarise(
      average_imdb_rating = mean(imdb_rating)
    )
    select(average_imdb_rating)
  summary_table$most_common_genre <- dataset %>%
    group_by(genre) %>%
    summarise(
      most_genre = max(genre)
    )
    select(most_genre)
  summary_table$least_common_genre <- dataset %>%
    group_by(genre) %>%
    summarise(
      least_genre = min(genre)
    )
    select(least_genre)
  summary_table$year_with_most_movies <- dataset %>%
    group_by(year) %>%
    summarise(num = n()) %>%
    arrange(desc(num)) %>%
    head(1) %>%
    select(year)
  summary_table$most_common_language <- dataset %>%
    group_by(language) %>%
    summarise(
      most_language = max(language)
    )
    select(most_language)
  summary_table$least_common_language <- dataset %>%
    group_by(language) %>%
    summarise(
      least_language = min(language)
    )
    select(least_language)
  
  return (summary_table)
}

# I included the table to make summarize the big data frames and make the information
# easier to visualize when looking at the summarized table.
# The table shows the average imdb rating per year, the average imdb rating per type,
# the most and least common genre, the year with the most movies released, and the most
# and last common language used in all of the movies.