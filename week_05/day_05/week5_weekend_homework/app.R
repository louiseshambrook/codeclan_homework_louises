# LIBRARIES ----

# Tidyverse
library(tidyverse)

# Shiny
library(shiny)
library(shinythemes)

# Widgets
# plotly (after doing a basic)



#Data
library(CodeClanData)

# DATA ----
game_data <- game_sales

# User Interface ----
ui <- fluidPage(

  #creates title
  titlePanel(tags$h1(tags$b("Best and worst reviewed games"))),
  theme = shinytheme("cerulean"),
  
# Sidebar layout ----
  # sets up a sidebar and main panel layout
  sidebarLayout(
    
    # creates the main side panel
    sidebarPanel(
      
      # creates dropdown menu # 1
      selectInput(
        "critic_score",
        "Rating",
        choices = sort(unique(game_data$critic_score)
                ),width="120px"),
      
# End of drop downs ----

      # creates a box to confirm updates
      actionButton("update",
                   "Filter rating")
    ,width = 2),

# Main panel ----

    # creates the main panel
    mainPanel(
      
      # sets up tab layout
      tabsetPanel(
        
# First tab (graphs) ----

        # creates first tab
        tabPanel(tags$b("Graphs"),
                 
        # sets up the fluid rows
        fluidRow(
          
          # creates the first width of columns
          column(width = 6,
                 (plotOutput("platform_output")
                )
          ),
          
          # creates the second width of columns
          column(width = 6,
                 plotOutput("developer_output")
          )
        )),

# Second tab (data) ----

        # creates second tab
        tabPanel(tags$b("Main data")
        , 

        # this adds the table directly in the second tab, which does not require fluid rows
        DT::dataTableOutput("table_output")
        )
      )
    )
  )
)

# Server ----
server <- function(input, output) {

# Sets a reusable filter for the serverside
  filtered_data <- eventReactive(input$update,{
    game_data %>%
      filter(critic_score == input$critic_score)
    
})

  # Creates a datatable in the data side
  output$table_output <- DT::renderDataTable ({
    filtered_data()
  })

  output$developer_output = renderPlot ({
    filtered_data() %>%
      ggplot(aes(x = developer, y = critic_score, fill = year_of_release)) +
      geom_col() +
      coord_flip() +
      theme_minimal() +
      labs(y = "Rating",
           x = "Game developer",
           fill = "Release year") +
      theme(legend.position = "none") 
  })
  
  output$platform_output = renderPlot ({
    filtered_data() %>%
      ggplot(aes(x = platform, y = critic_score, fill = year_of_release)) +
      geom_col() +
      coord_flip() +
      theme_minimal() +
      labs(y = "Rating",
           x = "Release platform",
           fill = "Release year") +
      theme(legend.position = "none") 
    })
}

# Run application ----
shinyApp(ui = ui, server = server)
