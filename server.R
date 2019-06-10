shinyServer(function(input, output){
  
  
  data_filt_Tech <- reactive({
    data %>% filter(Technology == input$selected_tech)
  })
  
  data_filt_TechState <- reactive({
    data %>% filter(Technology == input$selected_tech, Plant.State == input$selected_state)
  })
  
  data_filt_State <- reactive({
    data %>% filter(Plant.State == input$selected_state)
  })
  
  state_companyGroup <- reactive({
    data %>% filter(Plant.State == input$selected_state) %>% group_by(Entity.Name)
  })
  
  output$plant_map <- renderLeaflet({
    leaflet(data = data_filt_Tech()) %>% addTiles() %>%
    addMarkers(
      clusterOptions = markerClusterOptions() ,
      lng = ~ Longitude,
      lat = ~ Latitude,
      popup = ~ Plant.Name
    )
  })
  
  tech_byState <- reactive({
    data %>% filter(Technology == input$selected_tech) %>% group_by(Plant.State) %>% summarise(sum_MW = sum(capacity_MW)) %>% as.data.frame()
  })
    
  output$techbystate <- renderGvis({
    gvisGeoChart(tech_byState()[-1,], "Plant.State", "sum_MW",
                 options=list(region="US", displayMode="regions",
                              resolution="provinces",
                              width="auto", height="auto"))
    # using width="auto" and height="auto" to
    # automatically adjust the map size
  })
  
  # show data using DataTable
  output$table <- DT::renderDataTable({
    datatable(tech_byState()[-1,], rownames = FALSE) %>%
      formatStyle(input$selected,
                  background = "skyblue",
                  fontWeight = 'bold')
    # Highlight selected column using formatStyle
  })
  
  output$techByState <- renderPlot(
    data_filt_State() %>% group_by(Technology) %>% tally() %>% arrange(desc(n)) %>% 
    ggplot(aes(reorder(Technology, desc(Technology)), y = n)) + t +
    geom_col() + coord_flip() +
    labs(x = "Generator Technology", y = "Number of Power Generators"))
  
  output$powerByTechState <- renderPlot(
    data_filt_State() %>% group_by(Technology) %>% summarise(sum_MW = sum(capacity_MW)) %>% arrange(desc(sum_MW)) %>% 
    ggplot(aes(reorder(Technology, desc(Technology)), y = sum_MW)) + t +
    geom_col() + coord_flip() +
    labs(x = "Generator Technology", y = "Power Production (MW)"))
  
  #Max Info Boxes for Highest Power Production
  output$company_maxGenerator <- renderValueBox({
    valueBox(
      state_companyGroup() %>% tally() %>% filter(n==max(n)) %>% select(n), 
      state_companyGroup() %>% tally() %>% filter(n==max(n)) %>% select(Entity.Name), 
      icon=icon("list"), 
      width=12)
  })
  
  output$company_maxPower <- renderValueBox({
    valueBox(
      state_companyGroup() %>% summarise(sum_MW = sum(capacity_MW)) %>% filter(sum_MW == max(sum_MW)) %>% select(sum_MW), 
      state_companyGroup() %>% tally() %>% filter(n==max(n)) %>% select(Entity.Name) %>% select(Entity.Name), 
      icon=icon("list"), 
      width=12)
  })
  
  
  
  
})