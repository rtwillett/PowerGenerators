library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)
library(plotly)
library(leaflet)


data <- read.csv("./data/january_generator2019.csv", stringsAsFactors = F, header = T)

t <- theme_classic()