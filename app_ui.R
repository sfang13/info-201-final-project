library("shiny")
library("plotly")

# Chris' overview page --------
overview_page <- tabPanel (
  "Page one",
  sidebarLayout(),
  mainPanel()
)

overview_side_panel <- saidebarPanel(
  
)

overview_main_panel <- mainPanel(
  
)


#hannah's chart page --------

#creates side panel with widgets for chart 1 page
chart1_side_panel <- sidebarPanel(
  
)

#creates main panel with actual bar graph for chart 1 page
chart1_main_panel <- mainPanel(
  h1("What genres are most popular on each streaming platform? Do these align
     with other streaming platforms?"),
  plotlyOutput("chart1")
)

#creates the actual chart 1 page
chart_page_one <- tabPanel(
  "Popularity of Genres for TV Shows",
  sidebarLayout(
    chart1_side_panel,
    chart1_main_panel
  )
)

# ---------------------------




#ui for creating shinyApp
ui <- navbarPage(
  "title",
  page_one,
  chart_page_one
)
