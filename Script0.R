# Load in a library of extra tools, in this case, its "tidyverse"
library(tidyverse)

# Go through basic variables
A.number <- 99
A.word <- "Hello"
A.boolean <- TRUE
A.boolean2 <- FALSE
A.date <- as.Date(25000)
A.date2 <- as.Date(0)

A.vector.of.numbers <- c(1, 2, 3, 4, 5, 6)
A.vector.of.words <- c("one", "two", "three", "four", "five", "six")
A.mixed.vector <- c(1, "two", 3, "four", 5, "six")

A.list <- list("numbers"=A.vector.of.numbers, "A.word"="Word", "a.number"=A.number)

a.data.frame <- data.frame(A.vector.of.numbers, A.vector.of.words, "mixed"=A.mixed.vector)

subsetting.columns <- a.data.frame %>% select(numbers, mixed)