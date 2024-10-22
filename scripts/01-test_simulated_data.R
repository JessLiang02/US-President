#### Preamble ####
# Purpose: Tests the structure and validity of the simulated 2024 US elections dataset.
# Author: Jing Liang, Jierui Zhan
# Date: 21 October 2024
# Contact: jess.liang@mail.utoronto.ca, zhanjierui1@gmail.com
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Ensure you are in the `2024-US-Election-Prediction` rproj


#### Workspace setup ####
library(tidyverse)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has the expected number of columns (5)
if (ncol(simulated_data) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 5 columns.")
}

# Test the dataset has 500 rows
if (nrow(simulated_data) == 500) {
  message("Test Passed: The dataset has 500 rows.")
} else {
  stop("Test Failed: The dataset does not have 500 rows.")
}

# Test the 'state' column has at least two unique values for diversity
if (n_distinct(simulated_data$state) >= 2) {
  message("Test Passed: The 'state' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'state' column contains less than two unique values.")
}

# Test the 'pollster' column has at least two unique values for diversity
if (n_distinct(simulated_data$pollster) >= 2) {
  message("Test Passed: The 'pollster' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'pollster' column contains less than two unique values.")
}

# Test all percentage values are within a valid range (0 to 100)
if (all(simulated_data$pct >= 0 & simulated_data$pct <= 100)) {
  message("Test Passed: All pct values are between 0 and 100.")
} else {
  stop("Test Failed: Some pct values are outside the range 0 to 100.")
}

# Test for any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: No missing values in the dataset.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Test no empty strings in 'state' or 'pollster' columns
if (all(simulated_data$state != "" & simulated_data$pollster != "")) {
  message("Test Passed: No empty strings in 'state' or 'pollster' columns.")
} else {
  stop("Test Failed: Empty strings found in 'state' or 'pollster' columns.")
}
