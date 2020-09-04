# Load in a library of extra tools, in this case, its "tidyverse"
library(tidyverse)

# Go through basic variables
A.number <- 99
A.word <- "Hello"
A.boolean <- TRUE
A.boolean2 <- FALSE
# idosyncracies of R's date feature
A.date <- as.Date(25000)
A.date2 <- as.Date(0)

# make some vectors
A.vector.of.numbers <- c(1, 2, 3, 4, 5, 6)
A.vector.of.words <- c("one", "two", "three", "four", "five", "six")
A.mixed.vector <- c(1, "two", 3, "four", 5, "six")

# make a list
A.list <- list("numbers"=A.vector.of.numbers, "A.word"="Word", "a.number"=A.number)

# make a dataframe
a.data.frame <- data.frame("numbers"=A.vector.of.numbers, A.vector.of.words, "mixed"=A.mixed.vector)
# Select a couple of columns into a new dataframe
subsetting.columns1 <- a.data.frame %>% select(numbers, mixed)
subsetting.columns2 <- a.data.frame %>% select(A.vector.of.words, mixed)
# filter rows by value and store in new dataframe
filtering.rows1 <- a.data.frame %>% filter(numbers < 4)
filtering.rows2 <- a.data.frame %>% filter(numbers > 4)
filtering.rows3 <- a.data.frame %>% filter(numbers == 4)
filtering.rows4 <- a.data.frame %>% filter(numbers != 4)


# read from a csv file hosted online
csv.dataframe.online <- read.csv("https://raw.githubusercontent.com/Synectome/Rworkshop/master/Test.data.csv")

# look at the beginning of the dataframe
head(csv.dataframe.online)
tail(csv.dataframe.online)
summary(csv.dataframe.online)

# read from a csv file hosted locally
# 1st, get the current directory of your files
cwd <- getwd()
# 2nd, put in the file name of the file
file <- "Test.data.csv"
# 3rd, mash em together to create a path to the file
path <- file.path(cwd, "Desktop", 'OSI Work Folder', "R-Workshop", file)
# 4th, read the file
csv.dataframe.local <- read.csv(path)

# remove entries with a missing value in a given column
dropped.na.date <- csv.dataframe.online %>% drop_na(date)
dropped.na.age <- csv.dataframe.online %>% drop_na(age)

# to write one of these altered data frames to a csv file
path <- file.path(getwd(), "Desktop", 'OSI Work Folder', "R-Workshop", "No.missing.ages.csv")
write.csv(dropped.na.date, path, row.names = FALSE)


# Filter out those >=65 yrs
AgeFig <- plot_ly(x = dropped.na.age$age, type = "histogram") %>%
  layout(title="Age Histogram ",
         xaxis=list(title="Age"),
         yaxis=list(title="Number Users"))
AgeFig


yes <- dropped.na.age %>% filter(vegetarian == 'yes')
no <- dropped.na.age %>% filter(vegetarian == 'no')

age.veggie <- plot_ly(alpha = 0.5) %>%
  add_histogram(x = yes$age, name = "Vegetarian",
                opacity = 0.6,
                bingroup=5,
                marker = list(color = "teal")) %>%
  add_histogram(x = no$age, name = "Non-vegetarian",
                opacity = 0.6,
                bingroup=5,
                marker = list(color = "orange")) %>%
  layout(title="Age Histogram Of Vegetarians vs Non-Vegetarians in User Group",
         xaxis=list(title="Age"),
         yaxis=list(title="Users"),
         barmode = "overlay")
age.veggie


# my favourite libraries

