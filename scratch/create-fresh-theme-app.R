library(fresh)

create_theme(
  
  theme = "default",
  
  bs_vars_global(
    
    body_bg = "beige",
    
    text_color = "lightpink",
    
    link_color = "royalblue"
    
  ),
  
  bs_vars_navbar(
    
    default_bg = "darkseagreen",
    default_color = "grey"
  ),
  
  
  bs_vars_tabs(
    
    border_color = "firebrick"
  ),
  
  output_file = here::here("two-file-app", "www", "app-fresh-theme.css")
  
)





