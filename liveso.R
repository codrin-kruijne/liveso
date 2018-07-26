# This script extracts data from original downloaded files
# and merges them for the use in the Shiny application.

library(readr)
library(readxl)
library(dplyr)
library(rvest)
library(sf)

# Natural Earth country polygons
ne_countries <- st_read("Sources/Natural Earth/Large scale 110m/ne_110m_admin_0_countries.shp")
country_poly <- select(ne_countries, country_code = ISO_A3, geometry) %>%
                  mutate(bbox = list(st_bbox(geometry)))

# GDP data
GDP_per_cap <- read_csv("Sources/GDP/World Bank_ World Development Indicators_GDP_PPP_Data.csv")
GDP_per_cap[5:16] <- lapply(GDP_per_cap[5:16], as.numeric)
GDP_2016 <- GDP_per_cap %>%
              select(country = `Country Name`, country_code = `Country Code`, gdp_2016 = `2016 [YR2016]`)

# BLI data ### TO DO
BLI <- read_csv("Sources/OECD BLI/OECD_BLI.csv")

# SPI data
SPI <- read_excel("Sources/SPI/SPI 2017 Results.xlsx",
                 sheet = "2016 SPI",
                 range = "A1:BX237",
                 trim_ws = TRUE)
SPI[3:76] <- lapply(SPI[3:76], as.numeric)
SPI[1:2] <- lapply(SPI[1:2], as.factor)
SPI_2016 <- SPI %>%
              select(country = Country, country_code = `Country Code`, spi_2016 = `Social Progress Index`)

# Footprint data
fpc <- read_csv("https://query.data.world/s/fccwjcou6y3ndjbngjiasf4chx46wq", col_names = TRUE)
fpd <- read_csv("https://query.data.world/s/ciyn5ppqmtrjq7wspwzcpyuqlbo47h", col_names = TRUE)
FP <- fpd %>% left_join(fpc, by = c("country_code" = "GFN Country Code"))
FP_2014 <- FP %>%
             filter(year == 2014) %>%
             select(country_code = `ISO Alpha-3 Code`, fp_2014 = total)

# HPI data
HPI <- read_excel("Sources/HPI/hpi-data-2016.xlsx",
                  sheet = "Complete HPI data",
                  range = "B6:O146",
                  trim_ws = TRUE)
HPI[2:3] <- lapply(HPI[2:3], as.factor)
HPI_2016 <- HPI %>% select(country = Country, hpi_2016 = `Happy Planet Index`)

# Merge country data
world_df <- country_poly %>%
              inner_join(GDP_2016) %>%
              inner_join(SPI_2016) %>%
              inner_join(FP_2014) %>%
              inner_join(HPI_2016)
  
# Normalize country data
world_df <- world_df %>%
              mutate(gdp_scaled = scale(gdp_2016),
                     spi_scaled = scale(spi_2016),
                     fp_scaled = scale(fp_2014),
                     hpi_scaled = scale(hpi_2016))

# Create hover text
world_df$hover <- with(world_df, paste(country, '<br>',
                                         "GDP", round(gdp_2016, 2), '<br>',
                                         "SPI", round(spi_2016, 2), '<br>',
                                         "FP", round(fp_2014, 2), '<br>',
                                       "HPI", round(hpi_2016, 2)))

# Save data for shiny application use
saveRDS(world_df, "liveso/data/liveso_data.rds")