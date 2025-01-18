## import librarys
library(httr)
library(jsonlite)
library(tidyverse)

# Base API URL
base_url <- "https://api.openf1.org/v1/"

# List of endpoints or datasets
datasets <- c("stints", "drivers", "laps", "location", "meetings", 
              "position", "sessions", "weather", "car_data", "pit")

# Initialize a list to store results
all_data <- list()

for (dataset in datasets) {
  # Fetch data with error handling
  fetch_data_safe <- function(dataset) {
    tryCatch({
      url <- paste0(base_url, dataset)
      response <- GET(url)
      if (http_status(response)$category == "Success") {
        return(fromJSON(content(response, "text")))
        } else {
          stop("Request failed")
          }
      }, error = function(e) {
        warning(paste("Error fetching", dataset, ":", e$message))
        return(NULL)
      })
  }
  all_data[[dataset]] <- fetch_data_safe(dataset)
}
  



sints_df <- all_data[["stints"]] %>% as_tibble()
drivers_df <- all_data[["drivers"]] %>% as_tibble()
laps_df <- all_data[["laps"]] %>% as_tibble()
location_df <- all_data[["location"]] %>% as_tibble()
meetings_df <- all_data[["meetings"]] %>% as_tibble()
position_df <- all_data[["position"]] %>% as_tibble()
sessions_df <- all_data[["sessions"]] %>% as_tibble()
weather_df <- all_data[["weather"]] %>% as_tibble()
car_data_df <- all_data[["car_data"]] %>% as_tibble()
pit_df <- all_data[["pit"]] %>% as_tibble()



