box::use(
  app/logic/data
)

box::use(
  shiny[NS,tabPanel,fluidRow,column,moduleServer],
  bslib[card,card_header,card_body_fill],
  dplyr[select,filter],
  echarts4r[e_charts,e_line,e_x_axis,e_tooltip,
            echarts4rOutput,renderEcharts4r,e_theme,
            e_legend,e_title]
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Charity Raised",
           fluidRow(
             column(12,
                    card(
                      height = 700,
                      card_header("Charity Raised"),
                      card_body_fill(echarts4rOutput(ns("charplot")))
                    )
             )
           )
  ) 
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$charplot <- renderEcharts4r ({
      
      data$fetch_london_marathon() |>
        select(Year,Raised) |>
        filter(!is.na(Raised)) |>
        e_charts(Year) |>
        e_line(Raised) |>
        e_x_axis(scale = TRUE) |>
        e_theme("london") |>
        e_legend(show = FALSE) |>
        e_title("Amount raised for charity (£ millions)") |>
        e_tooltip(trigger = "axis",
                  backgroundColor  = "rgba(50,50,50,0.1)") 
      
    })
    
  })
}