box::use(
  shiny[navbarPage, moduleServer, NS],
  bslib[bs_theme,bs_themer],
  thematic[thematic_shiny]
)

box::use(
  app/view/CourseRecords/crTab,
  app/view/WinnerNationalities/wnTab,
  app/view/Participation/pTab,
  app/view/Charity/cTab
)

#' @export
ui <- function(id) {
  thematic::thematic_shiny()
  ns <- NS(id)
  navbarPage(
    "London Marathon",
    theme = bs_theme(bootswatch = "flatly"),
    crTab$ui(ns("crtab")),
    wnTab$ui(ns("wntab")),
    pTab$ui(ns("ptab")),
    cTab$ui(ns("ctab"))
  )
}

#' @export
server <- function(id) {
  #bslib::bs_themer()
  moduleServer(id, function(input, output, session) {
    crTab$server("crtab")
    wnTab$server("wntab")
    pTab$server("ptab")
    cTab$server("ctab")
  })
}
