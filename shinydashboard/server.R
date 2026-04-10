# Define Server Function

server <- function(input, output){
  
  # filter lake data ----
  filtered_lake_data_df <- reactive({
    
    lake_data %>% 
      
      filter(Elevation >= input$elevation_slider_input[1] & Elevation <= input$elevation_slider_input[2]) %>% 
      filter(AvgDepth >= input$avg_depth_slider_input[1] & AvgDepth <= input$avg_depth_slider_input[2]) %>% 
      filter(AvgTemp >= input$avg_temp_slider_input[1] & AvgTemp <= input$avg_temp_slider_input[2])
    
  })
  
  
  # Build leaflet map ----
  output$lake_map_output <- renderLeaflet({
    
    # Added from practice-script-app3.R
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
      addMarkers(data = filtered_lake_data_df(),
                 
                 lng= filtered_lake_data_df()$Longitude,
                 
                 lat= filtered_lake_data_df()$Latitude,
                 
                 popup = paste0(
                   
                   "Site_Name: ", filtered_lake_data_df()$Site, "<br>",
                   "Elevation: ", filtered_lake_data_df()$Elevation, " meters (above sea level)", "<br>",
                   "Avg Depth: ", filtered_lake_data_df()$AvgDepth, " meters", "<br>",
                   "Avg Lakebed: ", filtered_lake_data_df()$AvgTemp, "\u00B0C" , "<br>"
                   
                 ))
    
  })
  
  
  
}