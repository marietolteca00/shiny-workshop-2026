library(fresh)

create_theme(
 adminlte_color(
   
   light_blue = "grey",
 ),
 
 adminlte_global(
   content_bg = "bisque3"
 ),
 
 adminlte_sidebar(
   width = "400px",
   dark_bg = "darkseagreen",
   dark_hover_bg = "darksalmon",
   dark_color = "firebrick"
 ),
 
 output_file = here::here("shinydashboard","www","dashboard-fresh-theme.css")
  
  
)


