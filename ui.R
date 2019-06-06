shinyUI(dashboardPage(
        dashboardHeader(title = "Analysis of Power Generators in the USA", 
                        titleWidth = 500), 
        
        dashboardSidebar(
          img(src = "powerplant.jpeg", width = "100%"),
          width = 300, 
          sidebarMenu(
            menuItem("Introduction", tabName = "intro", icon = icon("intro")),
            menuItem("Power Generator Summary (National)", tabName = "map", icon = icon("map")),
            menuItem("Power Generator Summary (State)", tabName = "powergen", icon = icon("map")), 
            menuItem("Types of Power", tabName = "powertype", icon = icon("powertype")),
            menuItem("References", tabName = "refs", icon = icon("refs")),
            selectInput("selected_tech", "Technology", choices_tech, selected="Nuclear"), 
            selectInput("selected_state", "State", choices_state, selected = "TX")
          )
        ), 
        
        dashboardBody(
          tabItems(
            tabItem(tabName = "intro", 
                    box(HTML("<p>This is a placeholder</p>"))), 
            tabItem(tabName = "map",
                    fluidRow(
                            box(title = "Location of Power Generators",
                                width = 6, 
                                leafletOutput("plant_map")) ,
                            box(title = "Total Output of Power by State (MW)", 
                                width = 6, htmlOutput("techbystate"))
                    ), 
                    fluidRow(box(title = "Data Table", 
                                 DT::dataTableOutput("table"), width=12))), #,
                    #fluidRow(box(DT::dataTableOutput("table"), width=12))), 
            tabItem(tabName = "powergen", 
                    fluidRow(
                            box(title = "Number of Power Generators By Technology", 
                                width=6, 
                                plotOutput("techByState")), 
                            box(title = "Power Production By Technology", 
                                width=6, 
                                plotOutput("powerByTechState"))
                    )), 
            tabItem(tabName = "Types of Power"), 
            tabItem(tabName = "refs", 
                    box(HTML("<div><p>Placeholder</p></d>")))
          )
        )

)
)