library("shiny")
library("plotly")
library("shinythemes")

# Chris' overview page --------
overview_sidepanel <- sidebarPanel(
  tags$p(
    strong("Page one: Genre Popularity"),
    "What genres are most popular on each
         streaming platform?"
  ),
  tags$p(
    strong("Page 2: Age Demographics"),
    "What trends have emerged in producing content
         for each age demographic?"
  ),
  tags$p(
    strong("Page 3: Rating demographics"),
    "Does the length of a movie affect
         its rating outcome?"
  ),
  tags$p(
    strong("Page 4: Conclusions"),
    "Our takeaways and what we've learned from
         analyzing the data"
  ),
  tags$h4("Current best selling TV streaming platforms:"),
  tags$ol(
    tags$li("HBO Now"),
    tags$li("Youtube TV"),
    tags$li("Netflix"),
    tags$li("Sling TV"),
    tags$li("Amazon Prime"),
  ),
  tags$img(src = "streaming_services.jpg", height = "85%", width = "85%"),
)

overview_mainpanel <- mainPanel(
  tags$h1("Overview"),
  tags$img(src = "our_services2.jpg", height = "85%", width = "85%"),
  tags$h2("Purpose:"),
  tags$p(
    "Movies and TV Shows have been enjoyed across the world
         for many years now since the boom of TV streaming platforms.
         Platforms such as Netflix, Hulu, Disney +, Amazon Prime,
         etc, have help substitute the cinema and theatre experience
         that was cut off since quarantine started. Now
         families can sit back and relax at home as they watch their
         favourite TV shows or movies with their families and friends.
         In this project, we will be analyzing and transforming data from",
    strong("Netflix"), ", ", strong("Amazon Prime"), ", and ",
    strong("Disney Plus"), "to discover trends and reveal insight into
         how the movie industry has changed from the
         past up until the present."
  ),
  tags$h4("These are the sources we have used in this project:"),
  tags$a("     1. Netflix data",
    href = "https://www.kaggle.com/shivamb/netflix-shows"
  ),
  br(),
  tags$a("     2. Second Netflix data source",
         href = "https://www.kaggle.com/sarahjeeeze/imdbfile"),
  br(),
  tags$a("     3. Disney Plus data",
    href = "https://www.kaggle.com/unanimad/disney-plus-shows"
  ),
  br(),
  tags$a("     4. Amazon Prime data",
    href = "https://www.kaggle.com/nilimajauhari/amazon-prime-tv-shows"
  ),
  br(),
  br(),
  tags$p("From this data observation, we will be able to answer
    the following questions:"),
  tags$ul(
    tags$li("What are the user demographics of various
       streaming platforms?
       How have they changed over time?"),
    tags$li("What genres are most popular on each streaming platform?
       How have the popular genres changed over time?"),
    tags$li("How have the duration, ratings, viewers,
       and genres of tv shows and movies
       on various streaming platforms changed over the years? In 2020?")
  ),
  tags$p("We will be using our skills that we've
         learned throughout this quarter to analyze and filter
         through the data sets and examine the information results.")
)

overview_page <- tabPanel(
  "Overview",
  sidebarLayout(
    overview_sidepanel,
    overview_mainpanel
  )
)

# Hannah's chart page --------

# creates side panel with widgets for chart 1 page
chart1_side_panel <- sidebarPanel(
  h2("Widgets"),
  selectInput(
    inputId = "color",
    label = h4("Chart Colors"),
    choices = list(
      "Rainbow" = "Spectral",
      "Red to Green" = "RdYlGn",
      "Red to Blue" = "RdYlBu",
      "Pink to Green" = "PiYG",
      "Brown to Teal" = "BrBG",
      "Random" = "Paired"
    )
  ),
  sliderInput(
    inputId = "number",
    label = h4("Number of Genres to Show (per Platform)"),
    min = 1,
    max = 5,
    value = 3
  )
)

# creates main panel with actual bar graph for chart 1 page
chart1_main_panel <- mainPanel(
  h1("What genres are most popular on each streaming platform?"),
  h2("Do these align with other streaming platforms?"),
  p("Our first question revolved around the popularity of various genres of TV
    Shows on each streaming platform, specifically if there was a most popular
    genre on each, and if so, how they aligned with the other streaming
    platforms. The chart below compares the top n most popular genres
    (controlled by the slider to the left) as percentages of the total shows on
    each platform, in order to compare the popularity of TV show genres on
    streaming platforms. Because we are comparing the counts of categorical
    variables, we used a bar graph to visualize this analysis."),
  plotlyOutput("chart1"),
)

# creates the actual chart 1 page
chart_page_one <- tabPanel(
  "Genre Popularity",
  sidebarLayout(
    chart1_side_panel,
    chart1_main_panel
  )
)

# Sabrina's chart page --------

chart_page_two <- tabPanel(
  "Age Demographics",
  sidebarLayout(
    sidebarPanel(
      h2("Widgets"),
      sliderInput(
        "mark_size",
        label = h4("Change Size of Markers"),
        min = 1,
        max = 10,
        value = 5
      )
    ),
    mainPanel(
      h1("What trends have emerged in producing content for each age
         demographic?"),
      h2("How has quarantine in 2020 influenced or changed these trends?"),
      p("This chart attempts to show the amount of content produced for each
        age group every year on all of the streaming services to identify
        trends in content production and how the pandemic might have altered
        these trends. Specifically, the chart should help identify when content
        production was at its highest and lowest. This is done by comparing the
        # of Shows or Movies produced each year for each age group. Note that
        the age groups are classified by the Motion Picture Association film
        rating system."),
      plotlyOutput("chart_2")
    )
  )
)

# Ryu's chart page --------

chart_page_three <- tabPanel(
  "Ratings v Runtime",
  sidebarLayout(
    sidebarPanel(
      h2("Widgets"),
      sliderInput(
        "opac_data",
        label = h4("Change Opacity of Markers"),
        min = 0.1,
        max = 1,
        value = 0.5
      )
    ),
    mainPanel(
      h1("How do the runtime of movies effect the ratings, if at all?"),
      h2("Does how long a movie is effect how critically acclaimed it is?"),
      p("This chart organizes the IMDB ratings of movies from two streaming
        with IMDB rating and also identify the most popular movie rating and
        services based on their runtime to find how movie runtime correlates
        runtime on each streaming service. This was done by comparing IMDB
        ratings to runtimes to locate runtimes and ratings with a high (or low)
        concentration of movies. Note that that runtime is the total duration
        of a film, so TV Shows can not be included in this chart."),
      plotlyOutput("chart_3")
    )
  )
)

# Summary Page ---------------

summary <- tabPanel(
  "Summary",
  fluidPage(
    h1("Data Visualization Takeaways"),
    h2("Genre Popularity Takeaways"),
    p("This chart reveals that there are definitely most popular genres for each
      platform, and that they vary between platforms. For example, the most
      popular genre on Disney+, by far, is Animation, at 52.41% of its total TV
      streaming library, while the most popular on Amazon Prime Video is Drama
      at 51.15%, and the most popular on Netflix is International at 39.61%.
      While there are definitely potential questions in how these shows' genres
      were defined (what exactly constitutes a Drama, for example?), this
      does reveal some interesting insights into the popularity of various
      genres on these streaming services, as well as potentially how these
      platforms have optimized to increase their subscriptions and revenue. For
      example, there is very little overlap in the most popular genres on each
      platform (Comedy, Documentary, Kids, and Action are the only overlapping
      genres between the platforms, and not one of them made it into the top 5
      in all 3 platforms). In addition, the most popular genre on each platform
      didn't make it to the top 5 most popular genres for either of the other
      platforms. While this could be a coincidence, this could also be an
      intentional action on behalf of the streaming platforms to increase
      subscriptions and maximize revenue by seeking to fill a niche/provide
      primarily content users would be unable to find on other platforms, thus
      increasing the chances that the average person subscribes to all three
      platforms instead of just one and therein maximizing the profits of all
      three companies."),
    h2("Age Demographics Takeaways"),
    p("This chart reveals a content growth trend for each age group, and that
      content grows at a different rate for each age group. Approaching 2018,
      the amount of content rated R seemed to increase at an exponential rate,
      while the content growth rate of NC-17 material seemed to remain static.
      In addition, most age groups had the max amount of content production in
      2018, which indicates that streaming services were heavily saturated with
      new content in 2018. Specifically, 525 peices of content rated R and 350
      peices of content rated PG-13 was released in 2018, which is the largest
      amount of content ever released in a year for both categories. However,
      most age groups experienced a content decline in 2019, and an even steeper
      decline in 2020. For example, only 27 peices of content rated R has been
      released, which is significantly lower than the 446 peices of content
      rated R released in 2019. Though the growth rate of content per age group
      is different, production often increases and decreases at the same time
      for all age groups. The overall decline in 2020 is likely correlated with
      the pandemic, as the economy and and production process has been slowed.
      Even though the data is not complete (because 2020 is not over), it is
      unlikely that enough content will be produced in any age group to surpass
      growth rates leading up to 2018. Although the exponential increase of
      rated R material can not be explained by this chart, it suggests that
      interest in rated R content has increased, resulting in a wider audience
      and more revenue."),
    h2("Ratings v Runtime Takeaways"),
    p("This chart reveals movie runtimes and IMDB ratings which have the highest
      concentration of movies from Netflix and Disney+. For example, the highest
      concentration of movies from Netflix exists where the IMDB rating is 7. 
      In contrast, the highest concentration of movies from Disney+ exists 
      where the IMDB rating is 6.5. In addition, Netflix has multiple films 
      with a rating of 0, while Disney+ has a group of films with runtimes 
      between 0 and 15 minutes. Most movies in both streaming services have a 
      rating greater than 3 or less than 9, indicating that movies from Netflix
      and Disney+ deviate from their average IMDB rating a similar amount. 
      Netflix has more movies and a higher average IMDB rating than Disney+, 
      which likely accounts for part of its large subscriber base. Thus, this 
      chart illustrates how Netflix motivates its subscriber base with a larger
      amount of films because its average IMDB rating is not significantly 
      higher than the average rating for Disney+. The highest rated movie on 
      Netflix is 66 minutes while the highest rated movie on Disney+ is 124 
      minutes, which suggests that Disney+ contains longer films which attract 
      wider audiences while Netflix contains shorts films which attract wider 
      audiences.")
  )
)

# ui for creating shinyApp
ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    "Data Visualization on Movies and TV Shows",
    overview_page,
    chart_page_one,
    chart_page_two,
    chart_page_three,
    summary
  )
)
