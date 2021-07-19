#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(rvest)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Resultados de búsqueda del Sistema Nacional\nde Repositorios Digitales en forma de tabla exportable"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            textInput(inputId = "url",
                      label = "Ingresá la URL de la búsqueda",
                      placeholder = "Ej.: https://repositoriosdigitales.mincyt.gob.ar/vufind/Search/Results?lookfor=%22ciencia+abierta%22&type=AllFields"
                    ),
            sliderInput(inputId = "pages",
                        label = "Cantidad de páginas de resultados a scrapear",
                        min = 1,
                        max = 50,
                        value = 10)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          textOutput("prints"),
                  
          dataTableOutput(outputId = "results")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  data <- reactive({
    
    home <- "https://repositoriosdigitales.mincyt.gob.ar"
    links <- list()
    titles <- list()
    extra <- list() 
    
    for (i in 1:input$pages) {
      
      url <- paste(input$url, "&page=",
                   i, sep = "")
      
      htmlRepo <- read_html(url)
      
      links[i] <- htmlRepo %>% 
        html_nodes(".result .media .media-body .result-body .row .col-sm-12 .title") %>% 
        html_attr("href") %>% 
        list()
      
      titles[i] <- htmlRepo %>% 
        html_nodes(".result .media .media-body .result-body .row .col-sm-12 .title") %>% 
        html_text() %>% 
        list()
      
      extra[i] <- htmlRepo %>% 
        html_nodes(".result .media .media-body .result-body .row .col-xs-12") %>% 
        html_text() %>% 
        list() 
      
      # condicion que evalua si el resultado fue vacío
      if(is.na(links[[i]][1])) break
    }
    
    # pego la seccion de url al link obtenido para poder accederlo desde afuera del sitio
    links <- unlist(links) %>% 
      paste0(home,.)
    
    # vectorizo los titulos
    titles <- unlist(titles) %>% 
      str_trim()
    
    # transformo lista a matriz con las columnas de autores, fecha e idioma
    extra <- unlist(extra) %>% 
      str_trim() %>% 
      matrix(ncol = 3, byrow = T, dimnames = list(NULL,c("autores", "fecha_de_publicacion", "idioma")))
    
    extra[,1] <- extra[,1] %>% 
      str_remove("Autores:\n") %>% 
      str_remove_all("                    ") %>% 
      str_trim()
    
    extra[,2] <- extra[,2] %>% 
      str_remove("Fecha de publicación:") %>% 
      str_remove("\\.") %>% 
      str_trim()
    
    extra[,3] <- extra[,3] %>% 
      str_remove("Idioma:") %>%
      str_remove("\\.") %>% 
      str_trim()
    
    # armo la tabla de resultados
    resultados <- cbind(links, titles, extra) %>% 
      as.data.frame()
    
    resultados$fecha_de_publicacion <-  resultados$fecha_de_publicacion %>% 
      as.character() %>% 
      as.numeric()
    
   return(resultados)
  })
  
  output$results <- renderDataTable({
        
    data()
        
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
