#
#P5M - main.r
#
#Statistic Inference
#R example for statistical description
#

# Importing needed libraries
library(ggplot2)
library(tidyverse)

# Read CSV data
df <- read_csv("./../data/googleplaystore.csv")

# Create a circular plot for categories distribution

# Firstly, group data by category and find percentage for each one
Categories <- df %>%
  group_by(Category) %>%
  summarize(Frequency = n()) %>%
  mutate(Percentage = 100*(Frequency/sum(Frequency))) %>%
  select(Category, Percentage)

# Render circular plot (You won't suffer if you use RStudio :))
ggplot(
  Categories,
  aes(
    x="", y=Percentage,
    fill=paste(Category," (",round(Percentage,2),"%)")
  ))+
  geom_bar(
    stat = "identity",
    color="black"
  )+
  coord_polar(theta="y")+
  labs(fill="Category")+
  ggtitle("Categories distribution for google play store apps")

# Lets use a bar plot for comparing content rate

# Again, group data, this time by content rating
# (the public this app is designed for)
ContentRates <- df %>%
  group_by(`Content Rating`) %>%
  summarize(Frequency = n())

ContentRates

# Create barplot
ggplot(
  ContentRates,
  aes(
    x = `Content Rating`,
    y = Frequency,
    fill = `Content Rating`
  )) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  labs(
    x = "Content Rating",
    y = "Frequency"
  ) + ggtitle("Content rating distribution for google play store apps")

# Create a barplot presenting information related to reviews data

# Compare both free and paid applications Ratings

# Group needed data

# Remove data which is not grouped by Free or Paid
FilteredDf <- df %>%
  filter( Type == "Paid" | Type == "Free" )

x <- FilteredDf$Rating # Data field
y <- FilteredDf$Type # Grouping field

# Now we can create comparative boxplot
boxplot(
  x ~ y, na.rm = TRUE,
  names = c("Paid", "Free"),
  xlab = "Application type",
  ylab = "Rating"
)

# Finally make a small description of data by viewing some fields
print(df)