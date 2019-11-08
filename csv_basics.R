# If you don't have them already! In RStudio, check the "packages" pane.
install.packages("tidyverse") # https://www.tidyverse.org/packages/
install.packages("rvest")

# Load them for use.
library(tidyverse)

# Check/set working directory

# 1. Delimited files
banks <- read_csv("banklist.csv")

# What to do if the readr package guesses the wrong data type?
bank_spec <- cols(
  CERT = col_character()
  )

# Try again
banks <- read_csv("banklist.csv", col_types = bank_spec)

# 2. Excel
library(readxl)
same_banks <- read_xlsx('failed_banks.xlsx')

# Filter, only showing bank failures in NY
banks %>% filter(ST == 'NY')

# Move to new variable
ny_failures <- banks %>% filter(ST == 'NY')

# Remove a variable
rm(ny_failures)

# Preview a query before making a permanent change.
banks %>% filter(ST == 'NY') %>% View()

# Grouping
banks %>% group_by(ST)

# Summarizing- adding a counter field
banks %>% group_by(ST) %>% summarise(n())

# What to do about the 'n()' column name?
banks %>% group_by(ST) %>% summarise(ct = n())

# Arrange or sort the result
banks %>% group_by(ST) %>% summarise(ct = n()) %>% arrange(ct)

# Dates in R can be brutal
library(lubridate)

# This package is designed to simplify date reformatting
dmy(banks$`Closing Date`)

# Add a new column with dates we can work with
banks$fixed_date <- dmy(banks$`Closing Date`)

# See how many banks closed in each year
banks %>% group_by(year(fixed_date)) %>% summarise(ct = n())
