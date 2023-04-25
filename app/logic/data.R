box::use(
  here
)

box::use(
  utils[read.csv]
)

#' @export
fetch_winners <- function(){
  read.csv(here::here("data","winners.csv"))
}

#' @export
fetch_london_marathon <- function(){
  read.csv(here::here("data","london_marathon.csv"))
}
