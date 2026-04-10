# Load pkgs ---

library(shiny)
library(shinydashboard)
library(arrow)
library(tidyverse)
library(leaflet)
library(shinycssloaders)
library(markdown)


# read in data ----
# DO NOT use here::here 
lake_data <- read_parquet("data/lake_data_processed.parquet")
