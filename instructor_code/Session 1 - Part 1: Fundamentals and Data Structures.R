# ============================================================
# Title:  Session 1 - Introduction to Programming in R for Epidemiology
#         Part 1: Fundamentals and Data Structures
# Author: Sofia Fertuzinhos, PhD
# Date:   Jun 15th, 2026
# ============================================================

# Welcome to Positron! A few orientation notes before we begin:
#
# Positron is built by Posit and is a next-generation data science IDE 
# (Integrated Development Environment) based on the Code OSS foundation of
# VS Code. It provides a modern editor designed to be highly similar and
# familiar to RStudio users.
# 
# - The Editor (center): Your primary window for writing and editing scripts.
# - The Console (bottom panel): The fully interactive space where your code 
#   executes.
# - The Variables Pane (right sidebar): The dedicated area to inspect your 
#   defined data objects and environments.
# - The Plots & Help Panes (right sidebar): Your central hubs for viewing data
#   visualizations and reading documentation.
#
# To run a single line of code: place your cursor on the line and press
#   Ctrl + Enter (Windows/Linux) 
# or 
#   Cmd + Enter (Mac)
#
# To run the entire script:
#   Ctrl + Shift + Enter (Windows/Linux) 
# or 
#   Cmd + Shift + Enter (Mac)
#
# To get help on any function, run in the Console:
#   ?function_name


#---- Setting up your working directory ----#

# Check where R is currently looking for files:

getwd()

# In Positron, you can set your working directory via the file explorer:
#   1 - Navigate to the folder where your data is stored
#   2 - Right-click the folder and select "Set as Working Directory"
#
# Or programmatically:
# setwd("full/path/to/your/folder")
#
# Best practice: use an R Project (.Rproj) so your working
# directory is set automatically every time you open the project.
# File > New Project in Positron works exactly like RStudio.


#---- Four basic rules for writing R code ----#

# 1. Use # to annotate and document your code.
#    R ignores everything after # on the same line.

# 2. Use visible section breaks to organise your script,
#    for example:
#---- ----#

# 3. Numbers and arithmetic work just as on paper:

# A year
2025

# Basic arithmetic
100 + 23     # addition
200 - 47     # subtraction
50 * 4       # multiplication
1000 / 4     # division
2 ^ 8        # exponentiation

# The colon : generates a sequence of integers between two values:
1:10
10:1

# 4. Text (strings) must be wrapped in quotation marks "":

"cholera"
"Khartoum"

# Without quotes, R looks for an object with that name and
# will return an error if none exists.

# Exercise 1:
# Run the line below. Read the error message. Then fix it
# by adding quotation marks and run it again.

# Sudan


#---- Storing information in R objects ----#

# Objects let us save and reuse values without repeating ourselves.
# Syntax:   name <- value
# Shortcut: Alt + - (Windows) | Option + - (Mac)

# Example: store the name of an outbreak location
location <- "Khartoum, Sudan"

# Calling the object retrieves its value:
location

# We can use the object in further operations:
paste("Outbreak location:", location)

# Exercise 2:
# a) Assign the current year to an object called current_year.
# b) Assign the year a hypothetical outbreak started to an object
#    called outbreak_start (use any year you like).
# c) Calculate how many years ago the outbreak started.

current_year  <- 2025
outbreak_start <- 2019
current_year - outbreak_start


#---- Rules for naming R objects ----#

# - No spaces          : attack rate  <- invalid | attack_rate <- valid
# - Cannot start with a number : 1stCase <- invalid | case_1 <- valid
# - Case-sensitive     : Cases and cases are different objects
# - Avoid names of existing functions (e.g. do not use c, mean, sum)
# - Use lowercase_with_underscores (recommended in epidemiology/tidyverse style)


#---- Vectors: the building block of R data ----#

# A vector stores multiple values of the same data type.
# Use c() to create one (c = combine).

# --- Numeric vectors ---

# Ages of cases in an outbreak investigation:
case_ages <- c(4, 17, 23, 45, 67, 31, 8, 52)
case_ages

# Days from symptom onset to hospital admission (incubation proxy):
days_to_admission <- c(2, 1, 3, 5, 2, 4, 1, 3)
days_to_admission

# --- Character vectors ---

# Sex of each case:
case_sex <- c("male", "female", "female", "male",
              "male",  "female", "male",  "female")
case_sex

# Case outcome:
case_outcome <- c("recovered", "recovered", "died",    "recovered",
                  "recovered", "died",      "recovered","recovered")
case_outcome

# --- Logical vectors ---
# Useful for filtering. TRUE/FALSE — no quotes.

hospitalised <- c(TRUE, FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE)
hospitalised

# Exercise 3:
# a) Create a numeric vector called weekly_cases containing the
#    number of new cholera cases reported over 6 weeks:
#    104, 89, 132, 97, 76, 61
# b) Create a character vector called reporting_district with
#    the district name for each week (make up six names).
# c) Run both objects to confirm they are stored.

weekly_cases <- c(104, 89, 132, 97, 76, 61)

reporting_district <- c("District_A", "District_B", "District_C",
                        "District_D", "District_E", "District_F")


#---- Vectorised operations ----#

# R applies arithmetic to every element of a vector at once.
# This is called vectorisation and is one of R's great strengths.

# Calculate the attack rate (%) if the population at risk is 500 per case:
population_at_risk <- 500
attack_rate <- (case_ages / population_at_risk) * 100
# (illustrative only — using age as a stand-in count for demonstration)

# How many days over the threshold of 3?
days_to_admission > 3

# Sum of cases across all weeks:
sum(weekly_cases)

# Mean weekly cases:
mean(weekly_cases)

# Exercise 4:
# The case fatality rate (CFR) = (deaths / total cases) * 100
# a) Using the case_outcome vector, count the number of deaths.
#    Hint: sum(case_outcome == "died")
# b) Calculate the CFR for the eight cases above.

deaths      <- sum(case_outcome == "died")
total_cases <- length(case_outcome)
CFR         <- (deaths / total_cases) * 100
CFR


#---- Indexing vectors ----#

# Access specific elements using square brackets [].
# R uses 1-based indexing (the first element is [1], not [0]).

# Age of the first case:
case_ages[1]

# Ages of cases 2 through 5:
case_ages[2:5]

# All cases who were hospitalised (logical index):
case_ages[hospitalised]

# All ages EXCEPT the third case:
case_ages[-3]

# Exercise 5:
# a) Retrieve the weekly case count for week 3 from weekly_cases.
# b) Retrieve weeks 4 to 6.
# c) Which week had more than 100 cases?
#    Hint: weekly_cases > 100

weekly_cases[3]
weekly_cases[4:6]
which(weekly_cases > 100)


#---- Data frames: the core epidemiological data structure ----#

# A data frame is a table where:
#   - Each ROW    = one observation (e.g. one case)
#   - Each COLUMN = one variable   (e.g. age, sex, outcome)
#   - Columns can hold different data types (numeric, character, logical)

# This mirrors a linelist — the fundamental data structure in field epidemiology.

# Let's build a simple cholera linelist from our vectors:

linelist <- data.frame(
  case_id        = 1:8,
  age            = case_ages,
  sex            = case_sex,
  days_to_admit  = days_to_admission,
  hospitalised   = hospitalised,
  outcome        = case_outcome
)

linelist


#---- Inspecting a data frame ----#

# Dimensions (rows, columns):
dim(linelist)

# Column names:
colnames(linelist)

# Data types of each column:
str(linelist)

# First 6 rows:
head(linelist)

# Last 6 rows:
tail(linelist)

# Quick descriptive statistics:
summary(linelist)

# summary() returns for numeric columns:
#   Min., 1st Qu., Median, Mean, 3rd Qu., Max., and NA count if present
# For character columns:
#   Length, Class, Mode

# Exercise 6:
# a) How many rows and columns does linelist have?
# b) What data type is the outcome column?
#    Hint: typeof(linelist$outcome)
# c) What is the mean age of cases?

dim(linelist)
typeof(linelist$outcome)
mean(linelist$age)


#---- Accessing columns with $ ----#

# The $ operator extracts a single column as a vector:
linelist$age
linelist$outcome

# Unique values in a column — useful for checking categories:
unique(linelist$outcome)
unique(linelist$sex)

# Frequency table of a column — essential in epi:
table(linelist$outcome)
table(linelist$sex)

# Cross-tabulation (two-way table):
table(linelist$sex, linelist$outcome)


#---- Indexing data frames: [row, column] ----#

# Syntax: dataframe[row_index, column_index]
# Leave either blank to select all rows or all columns.

# First row, all columns:
linelist[1, ]

# All rows, second column:
linelist[, 2]

# Third row, fourth column:
linelist[3, 4]

# Rows 1 to 3, columns 1 to 3:
linelist[1:3, 1:3]

# You can also use column names instead of numbers:
linelist[1:3, "outcome"]

# Exercise 7:
# a) Retrieve all information for case number 5 (row 5).
# b) Retrieve the age and outcome columns for all cases.
# c) Retrieve the sex and outcome of cases 2, 4, and 6.

linelist[5, ]
linelist[, c("age", "outcome")]
linelist[c(2, 4, 6), c("sex", "outcome")]


#---- Filtering rows by condition ----#

# We can use logical conditions to select only rows meeting criteria.
# This is the equivalent of filtering in Excel or WHERE in SQL.

# Cases who died:
linelist[linelist$outcome == "died", ]

# Cases who were hospitalised AND under 18 (paediatric):
linelist[linelist$hospitalised == TRUE & linelist$age < 18, ]

# Cases who were NOT hospitalised:
linelist[linelist$hospitalised == FALSE, ]

# Conditional operators:
#   ==   equal to
#   !=   not equal to
#   >    greater than
#   <    less than
#   >=   greater than or equal to
#   <=   less than or equal to
#   &    AND (both conditions must be TRUE)
#   |    OR  (at least one condition must be TRUE)
#   %in% value is in a set: e.g. sex %in% c("male", "female")

# Exercise 8:
# a) Filter the linelist to show only female cases.
# b) Filter to show cases where days_to_admit is greater than 2.
# c) Filter to show hospitalised female cases only.

linelist[linelist$sex == "female", ]
linelist[linelist$days_to_admit > 2, ]
linelist[linelist$hospitalised == TRUE & linelist$sex == "female", ]


#---- Adding and modifying columns ----#

# Assign a new column using $:
# dataframe$new_column <- values

# Classify cases as paediatric (under 18) or adult:
linelist$age_group <- ifelse(linelist$age < 18, "paediatric", "adult")

linelist

# The ifelse() function evaluates a condition for every row:
#   ifelse(test, value_if_TRUE, value_if_FALSE)

# Create a binary numeric column for deaths (1 = died, 0 = recovered):
linelist$died <- ifelse(linelist$outcome == "died", 1, 0)

linelist

# Exercise 9:
# a) Add a column called severe that is TRUE if days_to_admit >= 4,
#    and FALSE otherwise.
# b) Add a column called case_label that pastes "Case" and case_id
#    together (e.g. "Case 1", "Case 2", ...).
#    Hint: paste("Case", linelist$case_id)

linelist$severe      <- ifelse(linelist$days_to_admit >= 4, TRUE, FALSE)
linelist$case_label  <- paste("Case", linelist$case_id)

linelist


#---- Handling missing values (NA) ----#

# In real linelists, missing data is the norm, not the exception.
# R represents missing values as NA (Not Available).

# Introduce some missing values to simulate real data:
linelist$age[3] <- NA
linelist$days_to_admit[6] <- NA

# Check if any NAs exist:
anyNA(linelist)

# Which specific elements are NA in a column:
is.na(linelist$age)

# Find the ROW INDEX of the NA:
which(is.na(linelist$age))

# NA values propagate through calculations:
mean(linelist$age)          # returns NA
mean(linelist$age, na.rm = TRUE)   # remove NAs before calculating

# Count missing values per column:
colSums(is.na(linelist))

# Exercise 10:
# a) How many cases have a missing age?
# b) Calculate the median days_to_admit, excluding missing values.
# c) Filter the linelist to show only rows where age is NOT missing.
#    Hint: !is.na(linelist$age)  — the ! means NOT

sum(is.na(linelist$age))
median(linelist$days_to_admit, na.rm = TRUE)
linelist[!is.na(linelist$age), ]


#---- Saving your cleaned data ----#

# Save the linelist as a .csv file in your working directory:
write.csv(linelist,
          "processed_data/cholera_linelist_clean.csv",
          row.names = FALSE)

# row.names = FALSE prevents R from writing an extra column of row numbers.
# Always use this for linelist-type data.

# To read it back in later:
# linelist_reload <- read.csv("processed_data/cholera_linelist_clean.csv")


#---- Summary: what you have learned ----#

# - How to navigate Positron and run R code
# - How to store values in objects using <-
# - How to create and operate on vectors
# - How to build and inspect a data frame (linelist)
# - How to access data using $ and [row, column] indexing
# - How to filter rows by condition
# - How to add and modify columns with ifelse()
# - How to detect and handle missing values (NA)
# - How to save a cleaned data frame to .csv

# In Part 2 we will import a real outbreak dataset, apply tidyverse
# cleaning functions (filter, mutate, select, case_when), and produce
# summary tables and epidemic curves.

# ============================================================
# End of script
# ============================================================