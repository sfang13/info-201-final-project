library(dplyr)
library(ggplot2)
library(stringr)

chart_1 <- function (netflix_data, disney_data, amazon_data){
  netflix_genres <- netflix_data %>%
    str_replace_all("Docuseries,", "Docuseries") %>%
    filter(type == "TV Show") %>%
    mutate(genre = word(listed_in, 1)) %>%
    count(genre) %>%
    mutate(streaming_service = "Netflix")
  
  #netflix_genres["Docuseries", ] <- sum(netflix_genres["Docuseries,", n], netflix_genres["Docuseries", n])
  #netflix_genres$genre <- sum(netflix_genres$genre[5], netflix_genres$genre[6])
  #str_replace_all(c(netflix_genres$genre, "Docuseries,", "Docuseries"))
  
  #netflix_genres$"Docuseries" = netflix_genres$"Docuseries" + netflix_genres$"Docuseries,"
  #Docuseries = sum(Docuseries + Docuseries,)
  
    
  disney_genres <- disney_data %>%
    filter(type == "series") %>%
    mutate(genre = word(genre, 1)) %>%
    count(genre) %>%
    mutate(streaming_service = "Disney+")
  
  amazon_genres <- amazon_data %>%
    mutate(genre = word(Genre, 1)) %>%
    count(genre) %>%
    mutate(streaming_service = "Amazon Prime Video")
}


#make them percentages of whole, otherwise can't compare them