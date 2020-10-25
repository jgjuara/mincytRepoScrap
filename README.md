# mincytRepoScrap
Proyecto para facilitar la búsqueda sistematica de literatura a través del buscador del Sistema Nacional de Repositorios Digitales de MinCyT Argentina
De la url a una tabla de resultados.

Búsquedas básicas 100% desde el script

Búsquedas avanzadas copiando URL de resultados genereda desde la [web de MinCyT](https://repositoriosdigitales.mincyt.gob.ar/vufind/Search/Home).

La idea es poder exportar los resultados de busqueda y sistematizar más facilmente la revision de literatura. Algún día quienes gestionan las web de los repositorios van a sumar un botoncito de "exportar búsqueda" y esto ya no será necesario.

Para búsquedas avanzadas primero obtener el link de resultados generado manualmente, mi ejemplo sería [ESTE](https://repositoriosdigitales.mincyt.gob.ar/vufind/Search/Results?filter%5B%5D=~language%3A%22spa%22&filter%5B%5D=~format%3A%22article%22&filter%5B%5D=~format%3A%22workingPaper%22&filter%5B%5D=~format%3A%22report%22&filter%5B%5D=~format%3A%22bookPart%22&filter%5B%5D=~eu_rights_str_mv%3A%22openAccess%22&filter%5B%5D=~reponame_str%3A%22Biblioteca+Digital+%28UBA-FCE%29%22&filter%5B%5D=~reponame_str%3A%22CONICET+Digital+%28CONICET%29%22&filter%5B%5D=~reponame_str%3A%22Filo+Digital+%28UBA-FFyL%29%22&filter%5B%5D=~reponame_str%3A%22Memoria+Acad%C3%A9mica+%28UNLP-FAHCE%29%22&filter%5B%5D=~reponame_str%3A%22RepHipUNR+%28UNR%29%22&filter%5B%5D=~reponame_str%3A%22Repositorio+Digital+San+Andr%C3%A9s+%28UdeSa%29%22&filter%5B%5D=~reponame_str%3A%22Repositorio+Digital+Universitario+%28UNC%29%22&filter%5B%5D=~reponame_str%3A%22Repositorio+Digital+UNLaM%22&filter%5B%5D=~reponame_str%3A%22Repositorio+Institucional+%28UNSAM%29%22&filter%5B%5D=~reponame_str%3A%22RIDAA+%28UNQ%29%22&filter%5B%5D=~reponame_str%3A%22SEDICI+%28UNLP%29%22&filter%5B%5D=publishDate%3A%22%5B2000+TO+2021%5D%22&join=AND&bool0%5B%5D=AND&lookfor0%5B%5D=salar%2A&lookfor0%5B%5D=actividad%2A&type0%5B%5D=AllFields&type0%5B%5D=AllFields) 

Scrapendo los resultados se llega a un csv que tiene la forma:

| Links         | Titulos       | Autores  | Fecha de Publicacion | Idioma |
| ------------- | ------------- | -------- | -------------------- | ------ |
| [link1](https://repositoriosdigitales.mincyt.gob.ar/vufind/Record/CONICETDig_e261125dc1aa186a1d5d7cea2567888e)  | Agonía y cierre de un ícono de la Argentina agroexportadora: el caso del Mercado Central de Frutos (1946-1976)           | Autores:
                      Cuesta, Eduardo Martín | Fecha de publicación: 2015. | Idioma: español. |
                      
Cargué a drive el csv a fin de visualizar el ejemplo completo:

https://docs.google.com/spreadsheets/d/1T512CRsHZ7OfTxH2tPIf5pH9ycNROApGEQSt7nJaTS4/edit?usp=sharing 
