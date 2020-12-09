library("shiny")
library("plotly")
library("ggplot2")

#sources for ui and server
source("app_ui.R")
source("app_server.R")

#shinyapp to create the website
shinyApp(ui = ui, server = server)