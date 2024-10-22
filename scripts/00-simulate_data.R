#### Preamble ####
# Purpose: Simulates a dataset for evaluating polling data, containing key variables including end date, pollster, state, and poll score, 
# to predict percentage support for Donald Trump in the upcoming 2024 U.S. election.
# Author: Jing Liang, Jierui Zhan
# Date: 21 October 2024
# Contact: jess.liang@mail.utoronto.ca, zhanjierui1@gmail.com
# License: MIT
# Pre-requisites: The `tidyverse` and `lubridate` packages must be installed
# Any other information needed? Ensure you are in the `2024-US-Election-Prediction` rproj


#### Workspace setup ####
library(tidyverse)
library(lubridate)
set.seed(123)

#### Simulate data ####
# Number of rows to simulate data for
n <- 500

# Pollsters 
pollsters <- c(pollsters <- c("Siena/NYT", "Ipsos", "Beacon/Shaw", "SurveyUSA", 
                              "Marist", "Quinnipiac", "YouGov", "Emerson"))

# State names 
states <- c("New York", "California", "Texas", "Florida", 
            "Ohio", "Georgia", "Arizona", "Nevada", 
            "North Carolina", "Pennsylvania", "Michigan", "Wisconsin", 
            "Montana", "Virginia", "Minnesota", "New Hampshire", 
            "Nebraska", "New Mexico", "Connecticut", "Rhode Island", 
            "Maryland", "Massachusetts", "Missouri", "Indiana", 
            "Iowa", "Washington", "National")

simulated_data <- tibble(
  pct = rnorm(n, mean = 45, sd = 3.5)  # Simulate percentage support for Trump
) %>%
  mutate(
    pollscore = rnorm(n, mean = -1, sd = 0.2),  # Simulate pollster score
    pollster = sample(pollsters, n, replace = TRUE),  # Assign pollster from the list randomly
    state = sample(states, n, replace = TRUE),  # Assign states randomly
    end_date = sample(seq(as.Date("2024-10-05"), as.Date("2024-10-15"), by = "day"), n, replace = T)  # Simulate end dates in an interval
  )


# Show the first few rows of the simulated data
simulated_data %>% head()

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
