# --- dashboard header --- 

header <- dashboardHeader(
  
  # Title ----
  title = "Fish Creek Watershed Lake Monitoring",
  
  # View Full Title without getting cutoff
  titleWidth = 400
)


# --- dashboard Sidebar ---

sidebar <- dashboardSidebar(
  
  # Sidebar Menu ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("earth-americas")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("accessible-icon"))
    
  )# END Sidebar Menu
)

# --- dashboard Body --- 
body <- dashboardBody(
  use_theme("dashboard-fresh-theme.css"),
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(
      
      # Use the tabName from Sidebar Menu !
      tabName = "welcome", 
      
      # left-hand column ----
      column(width = 6,
             
             # "background box" -----
              box( width = NULL,
                   
                   title = tagList(icon("water"),
                                   # Bold Text
                                   strong("Monitoring Fish Creek Watershed")),
                   includeMarkdown("text/intro.md"),
                   
                   # Image
                   tags$img(src = "FishCreekWatershedSiteMap_2020.jpg",
                            alt = "A map of Northern Alaska, showing Fish Creek Watershed Sites located within the National Petroleum Preserve.",
                            style = "max-width: 100%"),
                   # Caption
                   tags$p(tags$em("Map Source: ",
                                  # For Hyperlinking Text (URL and Text)
                                  tags$a(href = "http://www.fishcreekwatershed.org/", "FCWO")),
                          # Align text
                          style = "text-align: center;")
                   
                   ) # END background box
             
             ), # END left-hand column
      
      # right-hand column ----
      column(width = 6, 
             
             # data source box ----
             box(width = NULL,
                 
                 title = tagList(icon("table"),
                                 # Bold Text
                                 strong("Data Source")),
                 includeMarkdown("text/citation.md")
                 
                 ), # END data source box
             
             # disclaimer box ----
             box(width = NULL,
                 
                 title = tagList(icon("traignle-exclamation"),
                                 # Bold Text
                                 strong("Disclaimer")),
                 includeMarkdown("text/disclaimer.md"),
                 # Image
                 tags$img(src = "Cool_Wolf.jpeg",
                          alt = "Just a meme of a wolf with cowboy hat",
                          style = "max-width: 100%"),
                 # Caption
                 tags$p(tags$em("Source: Tiktok ",
                                # For Hyperlinking Text (URL and Text)
                                tags$a(href = "http://www.fishcreekwatershed.org/", "Howdy- Cool Wolf")),
                        # Align text
                        style = "text-align: center;")
                 
                 ) # END Disclaimor box
             
             )# END right-hand column
      
    ), # END welcome tabItem
    
    # dashboard tabItem
    tabItem(
      
      tabName = "dashboard",
      
      # input box ----
      box(width = 4,
          
          title = tags$strong("Adjust lake paramter ranges:"),
          
          # sliderInputs ----
          sliderInput(inputId = "elevation_slider_input",
                      label = "Elevation (meters above SL):",
                      min = min(lake_data$Elevation),
                      max = max(lake_data$Elevation),
                      # Creating a vector
                      value = c(min(lake_data$Elevation),max(lake_data$Elevation))),
          
          # sliderinput_ Avg_Depth ----
          sliderInput(inputId = "avg_depth_slider_input",
                      label = "Average Depth (meters): ",
                      min = min(lake_data$AvgDepth),
                      max= max(lake_data$AvgDepth),
                      value = c(min(lake_data$AvgDepth),max(lake_data$AvgDepth))),
          
          # sliderinput_ Avg_Temp ----
          sliderInput(inputId = "avg_temp_slider_input",
                      label = "Avg Temp °C: ",
                      min = min(lake_data$AvgTemp),
                      max= max(lake_data$AvgTemp),
                      value = c(min(lake_data$AvgTemp),max(lake_data$AvgTemp)))
          
          
          
          ), # END inputbox
      
      # leaflet box ----
      box(width = 8,
          
          leafletOutput(outputId = "lake_map_output") %>% 
            withSpinner(type = 4, color = "dodgerblue")
          
          ) # END leaflet box 
      
    ) # END dashboard tabItem
    
  ) # End tabItems
  
) # END dashboardBody


# --- Combine All Into DashboardPage ---
dashboardPage(header, sidebar, body)