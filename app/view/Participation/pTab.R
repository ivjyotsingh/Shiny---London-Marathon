box::use(
  app/logic/data
)

box::use(
  shiny[NS,tabPanel,fluidRow,column,moduleServer],
  bslib[card,card_header,card_body_fill],
  dplyr[select,filter],
  echarts4r[e_charts,e_line,e_x_axis,e_tooltip,
            echarts4rOutput,renderEcharts4r]
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Participation",
           fluidRow(
             column(12,
                    card(
                      height = 700,
                      card_header("Participation"),
                      card_body_fill(echarts4rOutput(ns("partplot")))
                    )
              )
           )
        ) 
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$partplot <- renderEcharts4r ({
      
      data$fetch_london_marathon() |>
        select(Year,Applicants,Accepted,Starters,Finishers) |>
        filter(!is.na(Applicants)) |>
        filter(!is.na(Accepted)) |>
        filter(!is.na(Starters)) |>
        filter(!is.na(Finishers)) |>
        e_charts(Year) |>
        e_line(Applicants) |>
        e_line(Accepted) |>
        e_line(Starters) |>
        e_line(Finishers) |>
        e_x_axis(scale = TRUE) |>
        e_tooltip(trigger = "axis")
      
    })
    
  })
}