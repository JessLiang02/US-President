#### Preamble ####
# Purpose: Tests the integrity and validity of the cleaned polling dataset for Donald Trump, 
# assuring it meets specified criteria for analysis.
# Author: Jing Liang, Jierui Zhan
# Date: 21 October 2024
# Contact: jess.liang@mail.utoronto.ca, zhanjierui1@gmail.com
# License: MIT
# Pre-requisites: 
  # - The `tidyverse`, `arrow` and `testthat` packages must be installed and loaded
  # - 02-clean_data.R must have been run
# Any other information needed? Ascertain that the dataset is located in data/02-analysis_data/.


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Test data ####

test_that("Dataset is successfully loaded", {
  expect_true(exists("data"))
})

test_that("Dataset has the correct number of columns and rows", {
  # Check number of columns
  expect_equal(ncol(data), 5)
  
  # Check number of rows
  expect_equal(nrow(data), 482)
})

test_that("Dataset has sufficient diversity in 'state' and 'pollster' columns", {
  # Check unique values in 'state' column
  expect_gte(n_distinct(data$state), 2)
  
  # Check unique values in 'pollster' column
  expect_gte(n_distinct(data$pollster), 2)
})

test_that("Percentage values are within the valid range (0 to 100)", {
  expect_true(all(data$pct >= 0 & data$pct <= 100))
})

test_that("Dataset contains no missing values", {
  expect_true(all(!is.na(data)))
})

test_that("No empty strings in 'state' or 'pollster' columns", {
  expect_true(all(data$state != "" & data$pollster != ""))
})
