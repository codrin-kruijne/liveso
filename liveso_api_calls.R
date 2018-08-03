library(httr)
library(jsonlite)
library(dplyr)

# Basic funtion to do API call

fp_call <- function(path){
  url <- modify_url("http://api.footprintnetwork.org/v1/", path = paste0("v1/", path))
  print(url)
  resp <- GET(url, authenticate("any-login", Sys.getenv("FP_KEY"), type = "basic"))
  print(resp)
  data <- fromJSON(rawToChar(resp$content))
  data
}

# Get a list of countries for which footprint data is available

fp_countries <- fp_call("countries")

# For each country get all data available

fp_req_links <- paste0("data/", fp_countries$countryCode, "/all")

fp_data <- data.frame()

for (link in fp_req_links){
  data <- fp_call(link)
  str(data)
  
  # Select Biocapacity and Ecological Footprint from Consumption (per capita)
  accounts <- data[data$record == "BiocapPerCap" | data$record == "EFConsPerCap", c("year", "countryCode", "countryName", "record", "value")]
  str(accounts)
  print(accounts)
  fp_data <- bind_rows(fp_data, accounts)
}

# Calculate footprint and change to ISO country codes

fp_data <- fp_data %>%
  spread(record, value) %>%
  mutate(reserve = BiocapPerCap - EFConsPerCap) %>%
  mutate(country_code = countrycode(countryName, "country.name", "iso3c")) %>%
  filter(!is.na(reserve))

saveRDS(fp_data, "liveso/data/fp_api_data.rds")