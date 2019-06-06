library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)
library(leaflet)
library(DT)
library(googleVis)

data <- read.csv("./data/january_generator2019.csv", stringsAsFactors = F, header = T)
data <- data %>% rename(
  capacity_MW = Nameplate.Capacity..MW.,
  capacity_MW_summer = Net.Summer.Capacity..MW.,
  capacity_MW_winter = Net.Winter.Capacity..MW.) %>% 
  select(-Google.Map,-Bing.Map) %>% 
  mutate(capacity_MW = gsub(",","", capacity_MW), 
         capacity_MW_summer = gsub(",","", capacity_MW_summer),
         capacity_MW_winter = gsub(",","", capacity_MW_winter))

colsToNum <- c("capacity_MW", "capacity_MW_summer", "capacity_MW_winter")
data[colsToNum] <- sapply(data[colsToNum], as.numeric)

t <- theme_classic()

# Global Variables
choices_state <- sort(c(unique(data$Plant.State)))
choices_tech <- sort(c(unique(data$Technology)))
