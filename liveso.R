# This script extracts data from original downloaded files
# and merges them for the use in the Shiny application.

library(tidyverse)
library(readxl)
library(httr)
library(sf)
library(countrycode)
library(data.world)

# Data.World connection
data.world::set_config(save_config(auth_token = "DW_ADMIN_TOKEN"))

# Natural Earth country polygons
ne_countries <- st_read("Sources/Natural Earth/Large scale 110m/ne_110m_admin_0_countries.shp")
country_poly <- select(ne_countries, country_code = ISO_A3, geometry) %>%
                  mutate(bbox = list(st_bbox(geometry)))

# GDP data https://datahelpdesk.worldbank.org/knowledgebase/articles/889386-developer-information-overview
GDP_per_cap <- read_excel("Sources/GDP/GDP_API_NY.GDP.PCAP.CD_DS2_en_excel_v2_10051632.xls",
                          sheet = "Data",
                          range = "A4:BJ268",
                          col_names = TRUE)

GDP_per_cap <- GDP_per_cap %>%
                 select(-c(`Indicator Name`, `Indicator Code`)) %>%
                 rename(country = `Country Name`, country_code = `Country Code`) %>%
                 gather(-c(country, country_code), key = "year", value = "gdp_per_cap")
GDP_per_cap$year <- as.numeric(GDP_per_cap$year)

GDP_2016 <- GDP_per_cap %>%
  filter(year == 2016) %>%
  select(country, country_code, gdp_2016 = gdp_per_cap)

# GINI data https://www.wider.unu.edu/database/world-income-inequality-database-wiid34
GINI <- read_excel("Sources/UN WIID/WIID3.4_19JAN2017New.xlsx",
                   sheet = "Sheet1",
                   col_names = TRUE)
# TEMPORARY FIX FOR MULTIPLE VALUES PER COUNTRY PER YEAR
GINI <- GINI %>%
          select(country_code = Countrycode3, year = Year, gini = Gini) %>%
          group_by(country_code, year) %>%
          summarize(gini_avg = mean(gini)) %>%
          ungroup()

# Human Development Index http://hdr.undp.org/en/indicators/137506#
HDI <- read_csv("Sources/HDI/HDI export.csv",
                col_names = TRUE,
                skip = 1)
HDI <- HDI %>%
         gather(`1990`:`2015`, key = "year", value = "hdi") %>%
         mutate(country_code = countrycode(Country, "country.name", "iso3c"))
HDI$year <- as.numeric(HDI$year)

# Well-being / happiness data
WHR <- read_excel("Sources/WHR/WHR2018Chapter2OnlineData.xls",
                  sheet = "Table2.1")
WHR_2017 <- read_excel("Sources/WHR/WHR2018Chapter2OnlineData.xls",
                       sheet = "Figure2.2",
                       range = "A1:B157") %>%
            rename(life_ladder_happiness = `Happiness score`, country = Country) %>%
            add_column(year = 2018) %>%
            select(country, year, life_ladder_happiness)

WHR <- WHR %>%
         rename(life_ladder_happiness = `Life Ladder`) %>%
         select(country, year, life_ladder_happiness) %>%
         bind_rows(WHR_2017) %>%
         mutate(country_code = countrycode(country, "country.name", "iso3c"))

# BLI data ### TO DO
# BLI <- read_csv("Sources/OECD BLI/OECD_BLI.csv")

# SPI data
SPI <- read_excel("Sources/SPI/SPI 2017 Results.xlsx",
                 sheet = "2016 SPI",
                 range = "A1:BX237",
                 trim_ws = TRUE)
SPI[3:76] <- lapply(SPI[3:76], as.numeric)
SPI[1:2] <- lapply(SPI[1:2], as.factor)
SPI_2016 <- SPI %>%
              select(country = Country, country_code = `Country Code`, spi_2016 = `Social Progress Index`)

# Footprint data sourced through API calls

fp_data <- readRDS("liveso/data/fp_api_data.rds")

FP_2014 <- fp_data %>%
             filter(year == 2014) %>%
             select(country_code, reserve)

# HPI data
HPI <- read_excel("Sources/HPI/hpi-data-2016.xlsx",
                  sheet = "Complete HPI data",
                  range = "B6:O146",
                  trim_ws = TRUE)
HPI[2:3] <- lapply(HPI[2:3], as.factor)
HPI <- HPI %>%
        mutate(life_exp_scaled = scale(`Average Life \r\nExpectancy`),
               well_being_scaled = scale(`Average Wellbeing\r\n(0-10)`),
               ineq_outcomes_scaled = scale(`Inequality of Outcomes`),
               footprint_scaled = scale(`Footprint\r\n(gha/capita)`),
               hpi_scaled = scale(`Happy Planet Index`))


HPI_2016 <- HPI %>% select(country = Country, hpi_2016 = `Happy Planet Index`)

# Sustainability Development Goals Index
SDG_2016 <- read_excel("Sources/SDG/sdg_index_and_dashboards_data_2016.xlsx",
                       sheet = "Sheet1",
                       range = "A1:CK150",
                       trim_ws = TRUE)
SDG_2017 <- read_excel("Sources/SDG/sdgi2017-data-web-final.xlsx",
                       sheet = "SDG INDEX 2017 DATA",
                       range = "A1:CK150",
                       trim_ws = TRUE)
SDG_2018 <- read_excel("Sources/SDG/SDG_Global_Index_Data_2018.xlsx",
                       sheet = "Sheet1",
                       range = "A1:IK194",
                       trim_ws = TRUE)

SDG <- SDG_2016 %>%
        select(ID, CountryName, "2016" = SDGI_Score) %>%
        left_join(SDG_2017 %>% select(ISO3, "2017" = `Global Index Score (0-100)`), by = c("ID" = "ISO3")) %>%
        left_join(SDG_2018 %>% select(id, "2018" = `Global Index Score (0-100): 2018 version`), by = c("ID" = "id")) %>%
        gather("2016":"2018", key = "year", value = "score")
SDG$year <- as.numeric(SDG$year)

# Measuring SHared Value? https://www.fsg.org/publications/measuring-shared-value
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
                     fp_scaled = scale(reserve),
                     hpi_scaled = scale(hpi_2016))

# Create hover text
world_df$hover <- with(world_df, paste(country, '<br>',
                                       "GDP", round(gdp_2016, 2), '<br>',
                                       "SPI", round(spi_2016, 2), '<br>',
                                       "FP", round(reserve, 2), '<br>',
                                       "HPI", round(hpi_2016, 2)))

## DIRTY MERGE JUST FOR TESTING
full_df <- country_poly %>%
            full_join(GDP_per_cap, by = c("country_code")) %>%
            full_join(GINI, by = c("country_code", "year")) %>%
            full_join(HDI %>% select(country_code, year, hdi), by = c("country_code", "year")) %>%
            full_join(fp_data %>% select(country_code, year, BiocapPerCap, EFConsPerCap, reserve), by = c("country_code", "year")) %>%
            full_join(WHR %>% select(country_code, year, life_ladder_happiness), by = c("country_code", "year")) %>%
            full_join(SDG %>% select(ID, year, score), by = c("country_code" = "ID", "year"))

# Save data for shiny application use
saveRDS(world_df, "liveso/data/liveso_data.rds")
saveRDS(GDP_per_cap, "liveso/data/gdp_per_cap_data.rds")
saveRDS(GINI, "liveso/data/gini_data.rds")
saveRDS(HDI, "liveso/data/hdi_data.rds")
saveRDS(WHR, "liveso/data/whr_data.rds")
saveRDS(SPI, "liveso/data/spi_data.rds")
saveRDS(HPI, "liveso/data/hpi_data.rds")
saveRDS(SDG, "liveso/data/sdg_data.rds")
saveRDS(fp_data, "liveso/data/fp_data.rds")

# Data.World Publishing trial

# write.csv(fp_data, "dataworld_liveso.csv")
# file_request <- file_create_request(file_name = "liveso.csv",
#                                     url = "dataworld_liveso.csv",
#                                     description = "liveso data merged")
# replace_request <- dataset_replace_request(title = "liveso dataset title",
#                                            visibility = "PRIVATE",
#                                            description = "R description",
#                                            summary = "R Studio summary",
#                                            license_string = "Other",
#                                            files = list(file_request))
# replace_dataset(dataset = "https://data.world/codrin/natural-progress", replace_request)