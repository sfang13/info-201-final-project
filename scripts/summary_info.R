library("dplyr")


amazon_data <- read.csv("data/amazon_prime_tv_shows.csv"
                      , stringsAsFactors = FALSE)
disney_data <- read.csv("data/disney_plus_shows.csv"
                      , stringsAsFactors = FALSE)
netflix_data <- read.csv("data/netflix_movies_and_tv.csv"
                       , stringsAsFactors = FALSE)
netflix_2_data <- read.csv("data/netflix_movies_and_tv_imdb_ratings.csv",
                           stringsAsFactors = FALSE)
#renamed amazon_data values for easier reference
amazon_data <- amazon_data %>%
  rename(
    year = Year.of.release,
    seasons = No.of.seasons.available,
    language = Language,
    genre = Genre,
    imdb_rating = IMDb.rating,
    age_rating = Age.of.viewers
  )

get_summ_info <- function(dataset_1, dataset_2, dataset_3, dataset_4) {
  rating_1 <- mean(na.omit(dataset_1[["imdb_rating"]]))
  rating_2 <- mean(na.omit(dataset_4[["rating"]]))
  oldest_year_1 <- min(na.omit(dataset_1[["year"]]))
  oldest_year_2 <- min(na.omit(dataset_3[["release_year"]]))
  oy1_title <- dataset_1 %>%
    filter(year == oldest_year_1) %>%
    pull(title)
  oy2_title <- dataset_3 %>%
    filter(release_year == oldest_year_2) %>%
    pull(title)
  summ_list <- list(ama_avg_rating = rating_1, net_avg_rating = rating_2,
                    ama_old_year = oldest_year_1, net_old_year = oldest_year_2,
                    ama_old_title = oy1_title, net_old_title = oy2_title)
  return(summ_list)
}

summ_info <- get_summ_info(amazon_data, disney_data,
                           netflix_data, netflix_2_data)
