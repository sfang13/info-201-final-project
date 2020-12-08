library("shiny")
library("plotly")
library("ggplot2")

source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)
