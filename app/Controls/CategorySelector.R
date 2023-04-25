box::use(
  app/logic/data
)

box::use(
  dplyr[select,pull],
  shiny[selectInput]
)

#' @export
selection <- function(categoryArg){
  
    data$fetch_winners() |>
    select(Category) |>
    unique() |>
    pull() -> categories
  
    selectInput(inputId = categoryArg,
                "Select a category",
                choices = categories,
                selected = 1)
  
}
