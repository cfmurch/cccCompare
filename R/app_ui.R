#' The application User-Interface
#' 
#' 
#' UI is defined with header, left sidebar and body
#' Sidebar has three options: "Home", "Data Explorer", "Operational Dashboard"
#' 
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#'
#' @import shiny
#' @import data.table
#'
#' @noRd
#' 




app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources - adds CSS (www) and Images (img)
    golem_add_external_resources(),
    
    bs4Dash::dashboardPage(
      
      #Title of webpage
      title="ADRC Data Visualization",
      fullscreen = TRUE,
      dark = NULL,
      scrollToTop = TRUE,
      preloader = preloader_spinner(),
      
      
      
      ##
      #Header of page - using shinydashboardPlus
      ##
      # 
      # header = dashboardHeaderPlus(titleWidth = 350,
      #                              
      #                              #Placement of UAB logo from images file
      #                              title = tags$a(tags$img(src="img/logo.png", height='80', width='252', style="padding-top: 10px"))
      #                              
      #                              #Defining date toggle (adrc_toggle) as clickable checkbox in header
      #                             
      # ),

        header = bs4Dash::dashboardHeader(
          title = tags$a(
            href = 'https://www.uab.edu/medicine/alzheimers/',
            target = "_blank",
            tags$img(
              src = 'www/logo-ADC.png',
              width = "100%",
              style = "padding: 8% 10% 2% 10%", 
              alt = 'UAB logo'
            )
          )
        ),
      
      
      
      ##
      #Sidebar of page - using shinydashboard
      ##
      
      sidebar = bs4Dash::dashboardSidebar(
        id = "main_sidebar",
        skin = 'dark',
        #Width of sidebar to accommodate width of title in header
        width = 350,
        minified = FALSE,
        
        #Main sidebar menu contains three submenus
        bs4Dash::sidebarMenu(id = "main_sidebar_menu",
                    
                    #ID Entry
                    shiny::textInput(inputId="id_entry", label="ADC ID"),
                    
                    #Process Button
                    shiny::actionButton(inputId = "compare_button", label = "Compare Reviews")
                    
                    )
      ),
      
      
      ##
      #Main body of page
      ##
      
      body = bs4Dash::dashboardBody(
        
        #Initialize use of waiter and call custom CSS file
        htmltools::tags$head(
          tags$link(rel="stylesheet", type="text/css", href="ADRC-theme.css"),
          tags$link(rel="stylesheet", type="text/css", href="ADRC-dash.css"),
          tags$style((".sidebar-menu li { margin-top:20px;}"))),
        
        fluidRow(bs4Dash::box(width=12,
                     title="Reviewer Comparison by Visit",
                     div(uiOutput("comparison_tables"), style="font-size:20px"),
                     align="center" ))
          
          
        
      )  #End of dashboardBody
      
      
    )  #End of dashboardPage
  )
}














#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd

golem_add_external_resources <- function(){
  
  #Resource path for CSS
  add_resource_path(
    'www', app_sys('app/www/')
  )
  
  #Resource path for Images (e.g. logo in header)
  add_resource_path(
    'img', system.file('app/img/', package = 'ADRCDash')
  )
  
  #Head tags including favicon
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'CCC Comparison Checker'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

