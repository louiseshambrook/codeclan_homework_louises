
library(shiny)
library(tidyverse)
library(shinythemes)
olympics_overall_medals <- read_csv("data/olympics_overall_medals.csv")

ui <- fluidPage(
  theme = shinytheme("yeti"),
  
  titlePanel(tags$h1(tags$b("Five Country Medal Comparison"
  ))),
  tabsetPanel(
    tabPanel(tags$b("Main Page"),
             sidebarLayout(
               sidebarPanel(
                 radioButtons("season_id", 
                              "Season",
                              choices = c("Summer",
                                          "Winter")
                 ),
                 selectInput("medal_type", 
                              "Medal",
                              choices = c("Gold",
                                          "Silver",
                                          "Bronze")
                 ),
               ),
               mainPanel(
                 plotOutput("medal_plot")
               )
          )
      ),
    tabPanel(tags$b("Website"),
             br(),
             br(),
             br(),
             tags$b(tags$a("For more information about the Olympics, click here",
                    href = "https://www.olympics.org/"
                    ))
             )
    )
)


server <- function(input, output) {

  output$medal_plot <- renderPlot ({
    olympics_overall_medals %>%
    filter(team %in% c("United States",
                       "Soviet Union",
                       "Germany",
                       "Italy",
                       "Great Britain")) %>%
    filter(medal == input$medal_type) %>%
    filter(season == input$season_id) %>%
    ggplot() +
    aes(x = team, y = count, fill = medal) +
    geom_col() +
    coord_flip() +
    scale_fill_manual(values = c("Gold" = "#f9e79f",
                                  "Silver" = "#ccd1d1",
                                  "Bronze" = "#edbb99")) +
    labs(y = "Medal count",
         x = "Country") +
    theme_minimal()
      
    
  })

}




# Run the application 
shinyApp(ui = ui, server = server)

