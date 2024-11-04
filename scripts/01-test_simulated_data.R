#### Preamble ####
# Purpose: Tests the structure and validity of the simulated 2024 US elections dataset.
# Author: Jing Liang, Jierui Zhan
# Date: 21 October 2024
# Contact: jess.liang@mail.utoronto.ca, zhanjierui1@gmail.com
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` and `testthat` packages must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Ensure you are in the `2024-US-Election-Prediction` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

test_that("Dataset is successfully loaded", {
  expect_true(exists("simulated_data"))
})

test_that("Dataset has the correct number of columns and rows", {
  # Check number of columns
  expect_equal(ncol(simulated_data), 5)
  
  # Check number of rows
  expect_equal(nrow(simulated_data), 500)
})

test_that("Dataset has sufficient diversity in 'state' and 'pollster' columns", {
  # Check unique values in 'state' column
  expect_gte(n_distinct(simulated_data$state), 2)
  
  # Check unique values in 'pollster' column
  expect_gte(n_distinct(simulated_data$pollster), 2)
})

test_that("Percentage values are within the valid range (0 to 100)", {
  expect_true(all(simulated_data$pct >= 0 & simulated_data$pct <= 100))
})

test_that("Dataset contains no missing values", {
  expect_true(all(!is.na(simulated_data)))
})

test_that("No empty strings in 'state' or 'pollster' columns", {
  expect_true(all(simulated_data$state != "" & simulated_data$pollster != ""))
})
