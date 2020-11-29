chart_1 <- function (netflix_data, disney_data, amazon_data){
  netflix_genres <- netflix_data %>%
    filter(type == "TV Show") #%>%
    #mutate(genre = )
  disney_genres <- disney_data %>%
    filter(type == "series") %>%
    group_by(genre)
}


#make them percentages of whole, otherwise can't compare them