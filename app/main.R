box::use(
  shiny[navbarPage, moduleServer, NS],
  bslib[bs_theme,bs_themer],
  thematic[thematic_shiny]
)

box::use(
  app/view/CourseRecords/crTab
)

#' @export
ui <- function(id) {
  thematic::thematic_shiny()
  ns <- NS(id)
  navbarPage(
    "London Marathon",
    theme = bs_theme(bootswatch = "flatly"),
    crTab$ui(ns("crtab"))
  )
}

#' @export
server <- function(id) {
  #bslib::bs_themer()
  moduleServer(id, function(input, output, session) {
    crTab$server("crtab")
  })
}
