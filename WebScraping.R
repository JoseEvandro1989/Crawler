library(robotstxt)
library(rvest)
library(selectr)
library(xml2)
library(dplyr)
library(stringr)
library(forcats)
library(magrittr)
library(tidyr)
library(ggplot2)
library(lubridate)
library(tibble)
library(purrr)

paths_allowed(
  paths = c("https://www4.bcb.gov.br/fis/cosif/estban.asp?frame=1")
)

estban <- read_html("https://www4.bcb.gov.br/fis/cosif/estban.asp?frame=1")
estban

estban %>% 
  html_nodes(".centralizado form select option") %>% 
  html_attrs("value", "title") %>% 
  html



scraplinks <- function(estban){
  # Create an html document from the url
  webpage <- xml2::read_html(url)
  # Extract the URLs
 c
  # Extract the link text
  link_ <- webpage %>%
    rvest::html_nodes(".centralizado form select option") %>%
    rvest::html_text()
  return(data_frame(link = link_, url = url_))
}



url_ <- estban %>%
  rvest::html_nodes(".centralizado form select option") %>%
  rvest::html_attr("value")

url_

link_ <- estban %>%
  rvest::html_nodes(".centralizado form select option") %>%
  rvest::html_text()

link_


scraplinks <- function(url){
  # Create an html document from the url
  webpage <- xml2::read_html(url)
  # Extract the URLs
  url_ <- webpage %>%
    rvest::html_nodes(".centralizado form select option") %>%
    rvest::html_attr("value")
  # Extract the link text
  link_ <- webpage %>%
    rvest::html_nodes(".centralizado form select option") %>%
    rvest::html_text()
  return(data.frame(link = link_, url =  trimws(url_), novaUrl = trimws(paste("https://www4.bcb.gov.br",url_))))
}

df <- scraplinks("https://www4.bcb.gov.br/fis/cosif/estban.asp?frame=1")

library(stringr)

df$novaUrl <- str_remove_all(df$novaUrl,"[[:space:]]")

df_agencias <- str_subset(df$novaUrl, "(?i)_AG")


df_agencias



write.csv(df, "estban.csv")


library(downloader)


urls <- df$novaUrl


urls

for (urll in df_agencias) {
  download(urll, dest="dataset.zip", mode="wb")
  unzip("dataset.zip", exdir = "C:/Users/evandro.barbosa/Desktop/Crawler/Agencia")
  
}



