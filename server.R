shinyServer(function(input, output){
  
  
  data_filt_Tech <- reactive({
    data_nuc <- data %>% filter(Technology == input$selected_tech)
  })
  
  data_filt_TechState <- reactive({
    data_nuc <- data %>% filter(Technology == input$selected_tech, Plant.State == input$selected_state)
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
  
})