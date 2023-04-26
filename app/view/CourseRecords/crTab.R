box::use(
  app/logic/data
)

box::use(
  app/Controls/CategorySelector
)

box::use(
  shiny[NS,tabPanel,fluidRow,column,moduleServer],
  bslib[card,card_header,card_body_fill],
  plotly[renderPlotly,ggplotly,plotlyOutput],
  dplyr[filter,select,mutate],
  ggplot2[ggplot,geom_line,aes,geom_point,theme_classic],
  hms[parse_hms]
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Course Records",
           fluidRow(
             column(3,
                    card(
                      height = 350,
                      card_header("Controls"),
                      card_body_fill(CategorySelector$selection(ns("categoryArg")))
                    )
             ),
             column(9,
                    card(
                      height = 780,
                      card_header("Course record over time"),
                      card_body_fill(plotlyOutput(ns("crotplot")))
                    )
                    
             )
           )
  ) 
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$crotplot <- renderPlotly ({
    
    plot <-   data$fetch_winners() |>
              filter(Category == input$categoryArg) |>
              mutate(Year = as.double(Year)) |>
              mutate(Time = parse_hms(Time)) |>
              select(Year,Time) |>
              unique() |>
              ggplot() +
              geom_line(mapping = aes(x = Year, y = Time),color = "darkgreen") +
              geom_point(mapping = aes(x = Year, y = Time),color = "darkgreen") +
              theme_classic()
            
              ggplotly(plot)
    
    })
  
  })
}