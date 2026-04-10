penguin_spp_pickerInput<- function(inputId){ # Add the argument here too 
  
  pickerInput(inputId = inputId,  # Name it a something generic - This will have to be added when using function
              label = "Select a species:",
              choices = c("Adelie", "Chinstrap", "Gentoo"),
              selected = c("Adelie", "Chinstrap", "Gentoo"),
              options = pickerOptions(actionsBox = TRUE),
              multiple = TRUE)
  
}
