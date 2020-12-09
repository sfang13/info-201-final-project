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
    "Movies and TV Shows have been anjoyed across the world
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
  tags$a("     2. Disney Plus data",
    href = "https://www.kaggle.com/unanimad/disney-plus-shows"
  ),
  br(),
  tags$a("     3. Amazon Prime data",
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
  h3("Do these align with other streaming platforms?"),
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
        label = "Change Size of Markers",
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
      radioButtons(
        inputId = "data_val",
        label = ("Streaming Service"),
        choices = list("Disney+" = 1, "Netflix" = 2),
        selected = 1
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
