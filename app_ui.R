library("shiny")
library("plotly")

page_one <- tabPanel (
  "Page one",
  sidebarLayout(),
    mainPanel()
  )


ui <- navbarPage(
  "title",
  page_one
)