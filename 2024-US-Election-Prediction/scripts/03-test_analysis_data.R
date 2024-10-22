#### Preamble ####
# Purpose: Tests the integrity and validity of the cleaned polling dataset for Donald Trump, 
# assuring it meets specified criteria for analysis.
# Author: Jing Liang, Jierui Zhan
# Date: 21 October 2024
# Contact: jess.liang@mail.utoronto.ca, zhanjierui1@gmail.com
# License: MIT
# Pre-requisites: 
  # - The `tidyverse`, `arrow` packages must be installed and loaded
  # - 02-clean_data.R must have been run
# Any other information needed? Ascertain that the dataset is located in data/02-analysis_data/.


#### Workspace setup ####
library(tidyverse)
library(arrow)

data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Test data ####

# Check if the dataset has the expected number of columns (5)
if (ncol(data) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 5 columns.")
}

# Test the dataset has 482 rows
if (nrow(data) == 482) {
  message("Test Passed: The dataset has 482 rows.")
} else {
  stop("Test Failed: The dataset does not have 482 rows.")
}

# Test the 'state' column has at least two unique values for diversity
if (n_distinct(data$state) >= 2) {
  message("Test Passed: The 'state' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'state' column contains less than two unique values.")
}

# Test the 'pollster' column has at least two unique values for diversity
if (n_distinct(data$pollster) >= 2) {
  message("Test Passed: The 'pollster' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'pollster' column contains less than two unique values.")
}

# Test all percentage values are within a valid range (0 to 100)
if (all(data$pct >= 0 & data$pct <= 100)) {
  message("Test Passed: All pct values are between 0 and 100.")
} else {
  stop("Test Failed: Some pct values are outside the range 0 to 100.")
}

# Test for any missing values in the dataset
if (all(!is.na(data))) {
  message("Test Passed: No missing values in the dataset.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Test no empty strings in 'state' or 'pollster' columns
if (all(data$state != "" & data$pollster != "")) {
  message("Test Passed: No empty strings in 'state' or 'pollster' columns.")
} else {
  stop("Test Failed: Empty strings found in 'state' or 'pollster' columns.")
}
