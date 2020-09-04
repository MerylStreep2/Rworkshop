# Load in a library of extra tools, in this case, its "tidyverse"
library(tidyverse)

# Go through basic variables
A.number <- 9
A.number2 <- A.number * 5

# an if statement
if (A.number2 == 45){
  print("its 45!")
}else{
  print("its not 45")
}

# a for loop with a 
for (i in 1:10){
  if (i > A.number){
    print("We've reached our target")
  }else{
    print(i)
  }
}

A.word <- "Hello"
A.scentence <- "  This is a scentance. Lots of punctuation! Simple lists: cell phone, wallet, glasses, keys.  "
trimmed.whitespace <- trimws(A.scentence)

# tun a string into a list
split.string <- strsplit(trimmed.whitespace, " ")


A.boolean <- TRUE
A.boolean2 <- FALSE
# idosyncracies of R's date feature
A.date <- as.Date(25000)
A.date2 <- as.Date(0)

# make some vectors
A.vector.of.numbers <- c(1, 2, 3, 4, 5, 6)
A.vector.of.words <- c("one", "two", "three", "four", "five", "six")
A.mixed.vector <- c(1, "two", 3, "four", 5, "six")

# difference of two vectors
setdiff(A.vector.of.numbers, A.mixed.vector)
# union of two vectors
union(A.vector.of.numbers, A.mixed.vector)
# intersection of two vectors
intersect(A.vector.of.numbers, A.mixed.vector)

# a for loop
square.vector <- c()
for (number in A.vector.of.numbers){
  square.vector <- append(square.vector, number*number)
}

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

# get a row by index
a.data.frame[2,]
# get a column by index
a.data.frame[,2]
# get a column by name
a.data.frame$numbers
# get a specific cell
a.data.frame[3,1]

# isolate rows with a loop
for (a.row in 1:nrow(a.data.frame)){
  print(a.data.frame[a.row])
}

# isolate cells in a column with a loop
for (a.row in 1:nrow(a.data.frame)){
  print(a.data.frame$A.vector.of.words[a.row])
}

# length of a vector, unique elements in a vector
new.vector <- c("a", "a", "b", "c", "d", "d")
length(new.vector)
unique(new.vector)
length(unique(new.vector))



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

# format the dates 
dropped.na.age$date <- sapply(dropped.na.age$date, function(x) as.Date(x, format="%Y-%m-%d")) 

# sort the dataframe by date
dropped.na.age <- dropped.na.age[order(dropped.na.age$date),] 

# to write one of these altered data frames to a csv file
path <- file.path(getwd(), "Desktop", 'OSI Work Folder', "R-Workshop", "No.missing.ages.csv")
write.csv(dropped.na.date, path, row.names = FALSE)

# lets make our dataframes beautiful with reactable!
library(reactable)
reactable(dropped.na.age)

reactable(dropped.na.age, columns = list(
  first.name = colDef(style = list(background='orange')),
  age = colDef(style = function(value) {
                 color <- if (value >= 35) {
                   "#008000"
                 } else if (value < 45) {
                   "#e00000"
                 }
                 list(fontWeight = 600, color = color, background="#ffeedb")
               })
  ))


# Creating plots with plotly!
library(plotly)

AgeFig <- plot_ly(x = dropped.na.age$age, type = "histogram") %>%
  layout(title="Age Histogram ",
         xaxis=list(title="Age"),
         yaxis=list(title="Number Users"))
AgeFig

# lets split our sample based on there diet
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

# save our plot as an html file!
library(htmlwidgets) # create html versions of plotly graphs
saveWidget(age.veggie, "Vegetarians", selfcontained = T)

# lets make a venn diagram!
library(VennDiagram)
cats <- dropped.na.age %>% filter(cats.or.dogs == 'cats')
dogs <- dropped.na.age %>% filter(cats.or.dogs == 'dogs')
both <- dropped.na.age %>% filter(cats.or.dogs == 'both')
neither <- dropped.na.age %>% filter(cats.or.dogs == 'neither')

# ---Ploting a venn diagram of the logical overlap
grid.newpage()
draw.triple.venn(area1=nrow(cats) + nrow(both), 
                 area2=nrow(dogs) + nrow(both),
                 area3=nrow(neither),
                 n12=nrow(both), 
                 n13=0,
                 n23=0,
                 n123=0,
                 category = c("Cats", "Dogs", "Neither"), 
                 lty = "blank", 
                 fill = c("skyblue", "pink1", "mediumorchid"))

# my favourite libraries-----------------------
library(zoo) # helpful utilities for data manipulation
library(lubridate) # helpful for manipulating dates
library(RColorBrewer) # creates nice colour palettes for visualizations and plots
library(shiny) # used to create R based web applications
library(gsheet) # an interface for using google spread sheet data without having to manually download the data.


