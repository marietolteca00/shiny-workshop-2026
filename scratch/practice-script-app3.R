# --- load pkgs ----
library(arrow)
library(leaflet)
library(tidyverse)

# read in data ----

lake_data <- read_parquet(here::here("shinydashboard", "data", "lake_data_processed.parquet"))

# Practice Filtering ----
filtered_lake_data <- lake_data %>% 
  
  filter(Elevation >= 8 & Elevation <= 20) %>% 
  
  filter(AvgDepth >= 2 & AvgDepth <= 3) %>%
  
  filter(AvgTemp >= 4 & AvgTemp <= 6)



# practice building leaflet ----
leaflet() %>% 
  
  # add tiles ----
  addProviderTiles(providers$Esri.WorldImagery ) %>% 
  
  # set view over AK
  setView(lng = -152.048442, lat = 70.249234, zoom = 6) %>% 
  
  # Add mini - map
  addMiniMap(toggleDisplay = TRUE,
             
             minimized = FALSE) %>% 
  
  # AddMarkers
  # After filtering - Make sure to replace with new data
  addMarkers(data = filtered_lake_data,
             
             lng= filtered_lake_data$Longitude,
             
             lat= filtered_lake_data$Latitude,
             
             popup = paste0(
               
               "Site_Name: ", filtered_lake_data$Site, "<br>",
               "Elevation: ", filtered_lake_data$Elevation, " meters (above sea level)", "<br>",
               "Avg Depth: ", filtered_lake_data$AvgDepth, " meters", "<br>",
               "Avg Lakebed: ", filtered_lake_data$AvgTemp, "\u00B0C" , "<br>"
             ))
  
  

