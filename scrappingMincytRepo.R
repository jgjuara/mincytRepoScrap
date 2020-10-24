library(tidyverse)
library(rvest)

#url de la busqueda
home <- "https://repositoriosdigitales.mincyt.gob.ar"
root<- "https://repositoriosdigitales.mincyt.gob.ar/vufind/Search/Results?filter%5B%5D=%7Elanguage%3A%22spa%22&filter%5B%5D=%7Eeu_rights_str_mv%3A%22openAccess%22&filter%5B%5D=publishDate%3A%22%5B2000+TO+%2A%5D%22&join=AND&bool0%5B%5D=AND&lookfor0%5B%5D=desigualdad+AND+salar%2A+-salares+-salar&type0%5B%5D=AllFields&page="
#cantidad de paginas de resultados
pages <- 1:12
links <- list()
titles <- list()
extra <- list()
for (i in pages) {
    url <- paste(root,
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
}

#pego la seccion de url al link obtenido para poder accederlo desde afuera del sitio
links <- unlist(links) %>% 
    paste0(home,.)
#vectorizo los titulos
titles <- unlist(titles) %>% 
    str_trim()
#transformo lista a matriz con las columnas de autores, fecha e idioma
extra <- unlist(extra) %>% 
    str_trim() %>% 
    matrix(ncol = 3, byrow = T, dimnames = list(NULL,c("autores", "fecha", "idioma")))
#armo 
resultados <- cbind(links, titles, extra) %>% 
    as.data.frame()

write_csv(resultados, path = "resultados.csv")
