# ---- load pkgs ----
library(shiny)
library(tidyverse)
library(palmerpenguins)
library(DT)
library(bslib)

#---- user interface ----
ui <- fluidPage(
  
  theme = bs_theme(#bootswatch = "solar"
    # Define background
    bg = "lightpink",
    fg = "blue",
    primary = "orange",
    base_font = font_google("Pacifico")
                   
                   ),
  
  
  # app title ----
  tags$h1("My App Title"), # alternatively, you can use the `h1()` wrapper function
  
  
  # app subtitle ---
  h2(strong("Exploring Antarctic Penguin Data")), # alternatively, `tags$h4(tags$strong("text"))`
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g)",
              min = 2700,
              max = 6300,
              # starting range
              value = c(3000, 4000)),
  
  # year input ----
  checkboxGroupInput(inputId = "year_input", label = "Select year(s):",
                     choices = c(2007, 2008, 2009), # or `unique(penguins$year)` | NOTE: update checkbox display name by using "New name" = "observation name" (e.g "The year 2007" = 2007)
                     selected = c(2007, 2008)),
  
  # DT output ----
  DT::dataTableOutput(outputId = "penguin_DT_output"),
  
  # body mass plot output ----
  plotOutput(outputId = "body_mass_scatterplot_output")
  
)

# ---- server ----
server <- function(input, output){
  
  # filter body masses ----
  body_mass_df <- reactive({
    
    penguins |>
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
    
  })
  
  output$body_mass_scatterplot_output <- renderPlot({
    
    
    # Add Code for Viz!
    ggplot(na.omit(body_mass_df()), # Everytime a `reactive` is used add a set of parenthesis
           aes(x = flipper_length_mm, y = bill_length_mm,
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)",
           color = "Penguin species", shape = "Penguin species") +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(legend.position.inside = c(0.85, 0.2),
            legend.background = element_rect(color = "white"))
    
  })
  

  # filter for years ----
  years_df <- reactive({
    penguins |> 
      filter(year %in% c(input$year_input)) # return observations where year is "in" the set of options provided by the user via the checkboxGroupInput
  })
  
  # render the DT::datatable ----
  output$penguin_DT_output <- DT::renderDataTable({
    
    DT::datatable(years_df(),
                  options = list(pagelength = 10),
                  rownames = FALSE)
    
  })


}
  
# ---- combine ui & server into an app ----
shinyApp(ui = ui, server = server)
  
  
  
  