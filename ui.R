shinyUI(dashboardPage(
        dashboardHeader(title="Analysis of Power Generators in the USA"), 
        
        dashboardSidebar(
          sidebarUserPanel("Power Generators in the USA"),
          img(src = "powerplant.jpeg", width = "100%"),
          sidebarMenu(
            menuItem("Introduction", tabName = "intro", icon = icon("intro")),
            menuItem("Power Generator Summary (National)", tabName = "map", icon = icon("map")),
            menuItem("Power Generator Summary (State)", tabName = "powergen", icon = icon("powergen")), 
            menuItem("Types of Power", tabName = "powertype", icon = icon("powertype")),
            menuItem("References", tabName = "refs", icon = icon("refs")),
            selectInput("selected_tech", "Technology", choices_tech), 
            selectInput("selected_state", "State", choices_state)
          )
        ), 
        
        dashboardBody(
          tabItems(
            tabItem(tabName = "intro"), 
            tabItem(tabName = "map", 
                    leafletOutput("plant_map")),
            tabItem(tabName = "powergen"), 
            tabItem(tabName = "Types of Power"), 
            tabItem(tabName = "References")
          )
        )

)
)