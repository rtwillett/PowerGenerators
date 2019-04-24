shinyUI(dashboardPage(
        dashboardHeader(title=""), 
        
        dashboardSidebar(
          sidebarUserPanel("Power Generator Analysis"), 
          sidebarMenu(
            menuItem("Power Generator Summary", tabName = "powergen", icon = icon("powergen")), 
            menuItem("Types of Power", tabName = "powertype", icon = icon("powertype"))
          )
        ), 
        
        dashboardBody(
          tabItems(
            tabItem(tabName = "powergen"), 
            tabItem(tabName = "Types of Power")
          )
        )

)
)