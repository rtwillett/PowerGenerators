shinyUI(dashboardPage(
        dashboardHeader(title = "Analysis of Power Generators in the USA", 
                        titleWidth = 500), 
        
        dashboardSidebar(
          img(src = "powerplant.jpeg", width = "100%"),
          width = 300, 
          sidebarMenu(
            menuItem("Introduction", tabName = "intro", icon = icon("intro")),
            menuItem("Power Generator Summary (National)", tabName = "map", icon = icon("map")),
            menuItem("Power Generator Summary (State)", tabName = "powergen", icon = icon("map"))#, 
            # menuItem("Types of Power", tabName = "powertype", icon = icon("powertype")),
            # menuItem("References", tabName = "refs", icon = icon("refs"))#,
            #selectInput("selected_tech", "Technology", choices_tech, selected="Nuclear")#, 
            #selectInput("selected_state", "State", choices_state, selected = "TX")
          )
        ), 
        
        dashboardBody(
          tabItems(
            tabItem(tabName = "intro", 
                    box(HTML("<h2>Data Visualization of the Preliminary Monthly Electric Generator Inventory</h2>
                             <p>This app visualizes the data from the <a href='https://www.eia.gov/electricity/data/eia860m/'>EIA-860M</a> report released 
                             every month by the U.S. Energy Information Administration (EIA), which contains data on all generators in the US with greater than 1 
                             megawatt (Mw) nameplate capacity. The report supplements and adds granularity to the annual 
                             <a href='https://www.eia.gov/electricity/data/eia860/'>EIA-860 report.</a> Learn more at the 
                             <a href='https://www.eia.gov/energyexplained/index.php?page=about_home'>EIA website</a></p>
                             
                             <p>Production and maintenance of a stable source of sustainable, reliable power is a matter of national security and crucial
                             infrastructure that drives the engine of commerce and enables the average citizen to carry out their daily lives. In the face of 
                             incontrovertable scientific support for climate change, impact of fuel sources on local economies, and health of the average 
                             citizen, the means and technology by which this power is generated has become a hot button issue in politics from the state to 
                             federal level.</p>
                             
                             <p>This app facilitates browsing and parsing of power generation technologies and megawatt outputs geographically throughout 
                             the US.</p>
                             
                             <iframe width='560' height='315' src='https://www.youtube.com/embed/nbPmsBmo03Y' frameborder='0'' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>
                             
                             <p><b>Note:</b></p> This is an additional project that I assigned myself and I have not yet implemented all final features."), 
                        width=12)), 
            tabItem(tabName = "map",
                    fluidRow(
                            box(title = "Location of Power Generators",
                                width = 6, 
                                leafletOutput("plant_map")) ,
                            box(selectInput("selected_tech", "Technology", choices_tech, selected="Nuclear"), 
                                title = "Total Output of Power by State (MW)", 
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
                                plotOutput("powerByTechState")) ), 
                        
                    fluidRow(    
                                box(column(2, selectInput("selected_state", "Select State", choices_state, selected = "TX")),
                                    column(5, 
                                           HTML("<b>Company in the State With the Most Generators</b>"), 
                                           valueBoxOutput("company_maxGenerator", width = "100%")),
                                    column(5, 
                                           HTML("<b>Company in the State With the Highest Power Generation</b>"), 
                                           valueBoxOutput("company_maxPower", width="100%")),
                                    width=12
                                )
                    )
                    )#, 
            #tabItem(tabName = "Types of Power"), 
            # tabItem(tabName = "refs", 
            #         box(HTML("<div><p>Placeholder</p></d>")))
          )
        )

)
)