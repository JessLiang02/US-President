#### Preamble ####
# Purpose: Models the percentage support for Donald Trump using polling data, 
# investigating relationships with key predictors including end date, pollster, state, and poll score.
# Author: Jing Liang, Jierui Zhan
# Date: 21 October 2024
# Contact: jess.liang@mail.utoronto.ca, zhanjierui1@gmail.com
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 03-test_data.R must have been run
# Any other information needed? Ascertain that the dataset is located in data/02-analysis_data/.


#### Workspace setup ####
library(tidyverse)

#### Read data ####
data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Starter models ####
# Model 1: pct as a function of end_date
model1 <- lm(pct ~ end_date, data = data)

# Model 2: pct as a function of end_date, state, pollscore, and pollster
model2 <- lm(pct ~ end_date + state + pollscore + pollster, data = data)

# Augment data with model predictions
data <- data |>
  mutate(
    fitted_date1 = predict(model1),
    fitted_date2 = predict(model2)
  )

# Plot model predictions
# Model 1
ggplot(data, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date1), color = "blue", linetype = "dotted") +
  theme_classic() +
  labs(y = "Trump percent", x = "Date", title = "Linear Model: pct ~ end_date")

# Model 2
ggplot(data, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date2), color = "blue", linetype = "dotted") +
  facet_wrap(vars(pollster)) +
  theme_classic() +
  labs(y = "Trump percent", x = "Date", title = "Linear Model: pct ~ end_date + state + pollscore + pollster")

#### Save model ####
saveRDS(
  model1,
  file = "models/model_date.rds"
)

saveRDS(
  model2,
  file = "models/model_date_state_pollscore_pollster.rds"
)



