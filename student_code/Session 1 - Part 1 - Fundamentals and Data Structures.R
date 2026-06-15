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
# The code will run in the Console

# fro more detaisl on Positron, see the official documentation:
# https://posit.co/docs/positron/getting-started/overview/

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
# directory is set automatically every time you open the project. In Positron
# you can do this by simply going to File > New Folder From Template. 
# It will create a new project folder with automated setup (environment, 
# version control, directory structure).

#---- Four basic rules for writing R code ----#

# 1. In a simple R script like this one, use # to annotate and 
# document your code. R ignores everything after # on the same line.

# 2. Use visible section breaks to organise your script,
#    for example:
#---- *title* ----#

# 3. Numbers and arithmetic work just as on paper:

# A year
2026

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
# Write a word and run the line. 


# What happened? R cannot interpret the word as a string of characters
# unless it is ...... ?


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
#    called outbreak_start (use any past year you like).
# c) Calculate how many years ago the outbreak started using the object
#    you have just created.




#---- Rules for naming R objects ----#

# - No spaces: 
#      attack rate  - invalid
#      attack_rate  - valid
# - Cannot start with a number: 
#      1stCase - invalid 
#      case_1 - valid
# - Case-sensitive: *Cases* and *cases* are different objects
# - Avoid names of existing functions (e.g. do not use c, mean, sum)
# - Use lowercase_with_underscores (recommended in epidemiology/tidyverse style)


#---- Vectors: the building block of R data ----#

# A vector stores multiple values of the same data type.
# Use c() to create one (c = combine).

# --- Numeric vectors ---

# Ages of cases in an outbreak investigation:
case_ages <- c(4, 17, 23, 45, 67, 31, 8, 52)
case_ages

# Days from symptom onset to hospital admission:
days_to_admission <- c(2, 1, 3, 5, 2, 4, 1, 3)
days_to_admission

# Number of new cholera cases reported per district:
weekly_cases <- c(104, 89, 132, 97, 76, 61)
weekly_cases

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
# a) Create a numeric vector called district_cases containing the
#    number of new cholera cases reported in six new districts:
#    45, 78, 23, 110, 65, 90
# b) Create a character vector called reporting_district with
#    the district name for each entry (make up six names).
# c) Run both objects to confirm they are stored.
# d) What is the difference between district_cases and weekly_cases?




#---- Vectorised operations ----#

# R applies arithmetic to every element of a vector at once.
# This is called vectorisation and is one of R's great strengths.

# --- Attack Rate ---

# Attack rate (%) = (number of cases / population at risk) * 100

# Population at risk per district (one value per district,
# matching the order of weekly_cases):
population_at_risk <- c(850, 640, 1100, 720, 500, 430)

# Calculate the attack rate for each district:
attack_rate <- (weekly_cases / population_at_risk) * 100
attack_rate
# Each value tells us what percentage of the at-risk population
# in that district became a case.

# Which districts exceeded a 10% attack rate?
attack_rate > 10

# Which district index numbers exceeded a 10% attack rate?
which(attack_rate > 10)

# --- Summary statistics on case counts ---

# Total cases across all districts:
sum(weekly_cases)

# Mean number of cases per district:
mean(weekly_cases)

# District with the highest and lowest case counts:
max(weekly_cases)
min(weekly_cases)

# Exercise 4:
# The case fatality rate (CFR) = (deaths / total cases) * 100
# a) Using the case_outcome vector, count the number of deaths.
#    Hint: create a new object and store the *sum(case_outcome == "died")*
# b) Calculate the total number of cases using length().
#    Hint: create another object and store the *length(case_outcome).
# c) Calculate the CFR and assign it to an object called CFR.
# d) Interpret the result: what does this CFR tell you?



#---- Indexing vectors ----#

# Access or inspect specific elements using square brackets [].
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
# a) Retrieve the weekly case count number 3 from weekly_cases.
# b) Retrieve weekly case count number 4 through 6.
# c) Which week had more than 100 cases?
#    Hint: weekly_cases > 100




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



#---- Adding and modifying columns ----#

# Assign a new column using $:
# dataframe$new_column <- values

# Classify cases as paediatric (under 18) or adult:
linelist$age_group <- ifelse(linelist$age < 18, "paediatric", "adult")

linelist

# The ifelse() function evaluates a condition for every row:
#   ifelse(test, value_if_TRUE, value_if_FALSE), similar to IF() in Excel.

# Create a binary numeric column for deaths (1 = died, 0 = recovered):
linelist$died <- ifelse(linelist$outcome == "died", 1, 0)

linelist

# Exercise 9:
# a) Add a column called severe that is TRUE if days_to_admit >= 4,
#    and FALSE otherwise.
# b) Add a column called case_label that pastes "Case" and case_id
#    together (e.g. "Case 1", "Case 2", ...).
#    Hint: paste("Case", linelist$case_id), similar to the function CONCATENATE() in excel

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

# ---- What comes next ----#
#
# In Part 2, Levi will cover project management for reproducible research:
# setting up an R environment with renv, exploring the project folder
# structure with fs::dir_tree(), and writing a README file to document
# your work for future collaborators.
#
# In Part 3, we will import a real outbreak dataset and learn how to write
# more efficient and reproducible code by applying tidyverse functions
# to clean and reshape the data, produce summary tables, and generate
# epidemic curves.

# ============================================================
# End of script
# ============================================================