box::use(
  app/logic/data
)

box::use(
  app/Controls/CategorySelector
)

box::use(
  shiny[NS,tabPanel,fluidRow,column,moduleServer],
  bslib[card,card_header,card_body_fill],
  dplyr[filter,select,group_by,summarise,arrange,n],
  echarts4r[e_charts,e_bar,e_flip_coords,e_tooltip,
            echarts4rOutput,renderEcharts4r,e_legend,
            e_theme]
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Winner Nationality",
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
                      card_header("Nationality of Winners"),
                      card_body_fill(echarts4rOutput(ns("winnatplot")))
                    )
                    
             )
           )
  ) 
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$winnatplot <- renderEcharts4r ({
      
        data$fetch_winners() |>
        filter(Category == input$categoryArg) |>
        select(Nationality) |>
        group_by(Nationality) |>
        summarise(Count = n(),.groups = "drop") |>
        arrange(Count) |>
        e_charts(Nationality) |>
        e_bar(Count) |>
        e_flip_coords() |>
        e_tooltip(trigger = "item",
                  backgroundColor  = "rgba(50,50,50,0.1)") |>
        e_legend(show = FALSE) |>
        e_theme("london")

      
    })
    
  })
}