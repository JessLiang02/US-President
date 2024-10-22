#### Preamble ####
# Purpose: Cleans the raw polling data collected for Donald Trump, 
#   emphasizing high-quality polls to evaluate voter support in the upcoming 2024 U.S. election.
# Author: Jing Liang, Jierui Zhan
# Date: 21 October 2024
# Contact: jess.liang@mail.utoronto.ca, zhanjierui1@gmail.com
# License: MIT
# Pre-requisites: 
  # - The `tidyverse`, `arrow`, `janitor` packages must be installed and loaded
  # - 00-simulate_data.R must have been run
  # - Ensure the polls dataset is downloaded from https://projects.fivethirtyeight.com/polls/president-general/2024/national/
# Any other information needed? Ascertain you are working in the appropriate project directory, 
# and ascertain that the required packages (tidyverse, arrow, janitor) are installed and loaded.

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)

#### Clean data ####
#### Prepare dataset ####
# Read in the data and clean variable names
data <- read_csv("data/01-raw_data/president_polls.csv") |>
  clean_names()

# Filter data to Trump estimates based on high-quality polls after she declared
clean_data <- data |>
  filter(
    candidate_name == "Donald Trump",
    numeric_grade >= 3 # high-quality polls only 
  ) |>
  mutate( # if missing state, make it national
    state = if_else(is.na(state), "National", state), 
    end_date = mdy(end_date)
  ) |>
  filter(end_date >= as.Date("2022-11-15")) |> # When Trump declared
    select(pct, pollster, state, end_date, pollscore) %>% na.omit()


#### Plot data ####
base_plot <- ggplot(clean_data, aes(x = end_date, y = pct)) +
  theme_classic() +
  labs(y = "Trump percent", x = "Date")

# Plots poll estimates and overall smoothing
base_plot +
  geom_point() +
  geom_smooth()

# Color by pollster
# This gets messy - need to add a filter - see line 21
base_plot +
  geom_point(aes(color = pollster)) +
  geom_smooth() +
  theme(legend.position = "bottom")

# Facet by pollster
# Make the line 21 issue obvious
# Also - is there duplication???? Need to go back and check
base_plot +
  geom_point() +
  geom_smooth() +
  facet_wrap(vars(pollster))

# Color by pollscore
base_plot +
  geom_point(aes(color = factor(pollscore))) +
  geom_smooth() +
  theme(legend.position = "bottom")


#### Save data ####
write_parquet(x = clean_data,
              sink = "data/02-analysis_data/analysis_data.parquet")




